class MiniaturesController < ApplicationController
   before_action :signed_in_user, only: [:new, :create, :edit, :update]
   before_action :admin_user,     only: :destroy

  def show
    @miniature = Miniature.find(params[:id])
  end

  def new
    @miniature = Miniature.new 
    @miniature.productions.build
    @miniature.sizes.build
    @miniature.sculptings.build
  end

  def create
    @miniature = Miniature.new(miniature_params)
    @production = @miniature.productions.build
    @size = @miniature.sizes.build
    @sculpting = @miniature.sculptings.build
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
    @miniatures = Miniature.paginate(page: params[:page])
  end

  def destroy
    Miniature.find(params[:id]).destroy
    flash[:success] = "Miniature destroyed."
    redirect_to miniatures_url
  end

private
    def miniature_params
      params.require(:miniature).permit(:name, :release_date, :material, :pcode, :notes, productions_attributes: [:id, :manufacturer_id, :miniature_id], sizes_attributes: [:id, :scale_id, :miniature_id], sculptings_attributes: [:id, :sculptor_id, :miniature_id])
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
