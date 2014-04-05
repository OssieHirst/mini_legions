class MiniaturesController < ApplicationController
   before_action :contributor, only: [:new, :create, :edit, :update]
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
    if params[:scales][:id]
      ## Convert ["", "1","2","4","8"] to [1,2,4,8]
      params[:scales][:id] = params[:scales][:id].reject(&:empty?).map(&:to_i)
      params[:scales][:id].each do |scale|
        @miniature.sizes.build(:scale_id => scale)
      end
    end
    if params[:manufacturers][:id]
      ## Convert ["", "1","2","4","8"] to [1,2,4,8]
      params[:manufacturers][:id] = params[:manufacturers][:id].reject(&:empty?).map(&:to_i)
      params[:manufacturers][:id].each do |manufacturer|
        @miniature.productions.build(:manufacturer_id => manufacturer)
      end
    end
    if params[:sculptors][:id]
      ## Convert ["", "1","2","4","8"] to [1,2,4,8]
      params[:sculptors][:id] = params[:sculptors][:id].reject(&:empty?).map(&:to_i)
      params[:sculptors][:id].each do |sculptor|
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
    @all_scales = Scale.all
    @all_manufacturers = Manufacturer.all
    @all_sculptors = Sculptor.all
    @size = @miniature.sizes.build
    @production = @miniature.productions.build
    @sculpting = @miniature.sculptings.build
  end

  def update
    @miniature = Miniature.find(params[:id])
    if params[:scales][:id]
      ## Convert ["", "1","2","4","8"] to [1,2,4,8]
      params[:scales][:id] = params[:scales][:id].reject(&:empty?).map(&:to_i) 
      ## Get the scale_id from sizes already present in database [1,2,5,6] 
      old_scales = @miniature.sizes.pluck(:scale_id)
      ## Find the new scales to be added [1,2,4,8] - [1,2,5,6] = [4,8]
      new_scales = params[:scales][:id] - old_scales 
      ## Find the old_scales to be deleted [1,2,5,6] - [1,2,4,8] = [5,6]
      old_scales = old_scales - params[:scales][:id] 
      ## Build new_scales [4,8]
      new_scales.each do |scale|
        @miniature.sizes.build(:scale_id => scale)
      end
      ## Delete old_scales [5,6]
      Size.delete_all(:scale_id => old_scales)
    end
    if params[:manufacturers][:id]
      ## Convert ["", "1","2","4","8"] to [1,2,4,8]
      params[:manufacturers][:id] = params[:manufacturers][:id].reject(&:empty?).map(&:to_i) 
      ## Get the manufacturer_id from productions already present in database [1,2,5,6] 
      old_manufacturers = @miniature.productions.pluck(:manufacturer_id)
      ## Find the new manufacturers to be added [1,2,4,8] - [1,2,5,6] = [4,8]
      new_manufacturers = params[:manufacturers][:id] - old_manufacturers 
      ## Find the old_manufacturers to be deleted [1,2,5,6] - [1,2,4,8] = [5,6]
      old_manufacturers = old_manufacturers - params[:manufacturers][:id] 
      ## Build new_manufacturers [4,8]
      new_manufacturers.each do |manufacturer|
        @miniature.productions.build(:manufacturer_id => manufacturer)
      end
      ## Delete old_manufacturers [5,6]
      Production.delete_all(:manufacturer_id => old_manufacturers)
    end
    if params[:sculptors][:id]
      ## Convert ["", "1","2","4","8"] to [1,2,4,8]
      params[:sculptors][:id] = params[:sculptors][:id].reject(&:empty?).map(&:to_i) 
      ## Get the sculptor_id from sculptings already present in database [1,2,5,6] 
      old_sculptors = @miniature.sculptings.pluck(:sculptor_id)
      ## Find the new sculptors to be added [1,2,4,8] - [1,2,5,6] = [4,8]
      new_sculptors = params[:sculptors][:id] - old_sculptors 
      ## Find the old_sculptors to be deleted [1,2,5,6] - [1,2,4,8] = [5,6]
      old_sculptors = old_sculptors - params[:sculptors][:id] 
      ## Build new_sculptors [4,8]
      new_sculptors.each do |sculptor|
        @miniature.sculptings.build(:sculptor_id => sculptor)
      end
      ## Delete old_sculptors [5,6]
      Sculpting.delete_all(:sculptor_id => old_sculptors)
    end
    if @miniature.update_attributes(miniature_params)
      flash[:success] = "Miniature updated"
      redirect_to @miniature
    else
      render 'edit'
    end
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
      params.require(:miniature).permit(:name, :release_date, :material, :pcode, :notes, :quantity, :random, :set, productions_attributes: [:id, :manufacturer_id, :miniature_id], sizes_attributes: [:id, :scale_id, :miniature_id], sculptings_attributes: [:id, :sculptor_id, :miniature_id], minilines_attributes: [:id, :line_id, :miniature_id])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def contributor
      redirect_to(root_url) unless current_user.contributor?
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
  end
end
