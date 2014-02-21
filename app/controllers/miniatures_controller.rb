class MiniaturesController < ApplicationController
   before_action :user_signed_in?, only: [:new, :create, :edit, :update]
   before_action :admin_user,     only: :destroy

   def ancestry_options(items, &block)
      return ancestry_options(items){ |i| "#{'&nbsp; &nbsp; &nbsp;' * i.depth} #{i.name}".html_safe } unless block_given?

      result = []
      items.map do |item, sub_items|
        result << [yield(item), item.id]
        #this is a recursive call:
        result += ancestry_options(sub_items, &block)
      end
      result
   end

   def in_collection
    @miniature = Miniature.find(params[:miniature_id])
    @usergot = User.joins(:collections).where(collections: {status: 'Got', miniature: @miniature}).uniq
    @userwant = User.joins(:collections).where(collections: {status: 'Want', miniature: @miniature}).uniq
   end

   def imagevote
    @miniature = Miniature.find(params[:miniature_id])
   end

   def import
     Miniature.import(params[:file])
     redirect_to miniatures_path, notice: "Miniatures imported."
   end

  def show
    @miniature = Miniature.find(params[:id])
  end

  def new
    @miniature = Miniature.new 

    @all_scales = Scale.all
    @all_manufacturers = Manufacturer.all
    @all_sculptors = Sculptor.all

    @size = @miniature.sizes.build
    @production = @miniature.productions.build
    @sculpting = @miniature.sculptings.build
  end

  def create
    @miniature = Miniature.new(miniature_params)
    params[:scales][:id].each do |scale|
      if !scale.empty?
        @miniature.sizes.build(:scale_id => scale)
      end
    end
    params[:manufacturers][:id].each do |manufacturer|
      if !manufacturer.empty?
        @miniature.productions.build(:manufacturer_id => manufacturer)
      end
    end
    params[:sculptors][:id].each do |sculptor|
      if !sculptor.empty?
        @miniature.sculptings.build(:sculptor_id => sculptor)
      end
    end

    if @miniature.save
      redirect_to @miniature
    else
      render 'new'
    end
  end

  def edit
    @miniature = Miniature.find(params[:id])  
  end

  def update
    @miniature = Miniature.find(params[:id])
    if params[:add_size]
      # rebuild the scale attributes that doesn't have an id
      unless params[:miniature][:sizes_attributes].blank?
        for attribute in params[:miniature][:sizes_attributes]
          @miniature.sizes.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      # add one more empty scale attribute
    @miniature.sizes.build
    elsif params[:remove_size]
        # collect all marked for delete scale ids
          removed_sizes = params[:miniature][:sizes_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
          # physically delete the scales from database
          Size.delete(removed_sizes)
          flash[:notice] = "Scale removed."
          for attribute in params[:miniature][:sizes_attributes]
            # rebuild scale attributes that doesn't have an id and its _destroy attribute is not 1
            @miniature.sizes.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
          end
    else
      if params[:add_production]
      # rebuild the mfr attributes that doesn't have an id
      unless params[:miniature][:productions_attributes].blank?
        for attribute in params[:miniature][:productions_attributes]
          @miniature.productions.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      # add one more empty mfr attribute
    @miniature.productions.build
    elsif params[:remove_production]
        # collect all marked for delete mfr ids
          removed_productions = params[:miniature][:productions_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
          # physically delete the mfr from database
          Production.delete(removed_productions)
          flash[:notice] = "Manufacturer removed."
          for attribute in params[:miniature][:productions_attributes]
            # rebuild mfr attributes that doesn't have an id and its _destroy attribute is not 1
            @miniature.productions.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
          end
    else
      if params[:add_sculpting]
      # rebuild the sculptor attributes that doesn't have an id
      unless params[:miniature][:sculptings_attributes].blank?
        for attribute in params[:miniature][:sculptings_attributes]
          @miniature.sculptings.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      # add one more empty sculptor attribute
    @miniature.sculptings.build
      elsif params[:remove_sculpting]
        # collect all marked for delete sculptor ids
          removed_sculptings = params[:miniature][:sculptings_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
          # physically delete the sculptor from database
          Sculpting.delete(removed_sculptings)
          flash[:notice] = "Sculptor removed."
          for attribute in params[:miniature][:sculptings_attributes]
            # rebuild sculptor attributes that doesn't have an id and its _destroy attribute is not 1
            @miniature.sculptings.build(attribute.last.except(:_destroy)) if (!attribute.last.has_key?(:id) && attribute.last[:_destroy].to_i == 0)
          end
    else
      # save goes as usual
     if @miniature.update_attributes(miniature_params)
      flash[:success] = "Miniature updated"
      redirect_to @miniature and return
    end
     end
   end
 end
      render 'edit'
  end

  def index
    @search = Miniature.search(params[:q])
    @search.sorts = 'name ASC' if @search.sorts.empty?  
    @miniatures = @search.result.paginate(page: params[:page])
  end

  def destroy
    Miniature.find(params[:id]).destroy
    flash[:success] = "Miniature destroyed."
    redirect_to miniatures_url
  end

private
    def miniature_params
      params.require(:miniature).permit(:name, :release_date, :material, :pcode, :notes, productions_attributes: [:id, :manufacturer_id, :miniature_id], sizes_attributes: [:id, :scale_id, :miniature_id], sculptings_attributes: [:id, :sculptor_id, :miniature_id], minilines_attributes: [:id, :line_id, :miniature_id])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end
end
