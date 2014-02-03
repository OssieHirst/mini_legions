class MinisetsController < ApplicationController
   before_action :user_signed_in?, only: [:new, :create, :edit, :update]
   before_action :admin_user,     only: :destroy

  def show
    @miniset = Miniset.find(params[:id])
  end

  def new
    @miniset = Miniset.new 
    @all_scales = Scale.all
    @all_manufacturers = Manufacturer.all
    @all_sculptors = Sculptor.all
    @size = @miniset.sizes.build
    @production = @miniset.productions.build
    @sculpting = @miniset.sculptings.build
  end

  def edit
    @miniset = Miniset.find(params[:id])
    @all_scales = Scale.all
    @all_manufacturers = Manufacturer.all
    @all_sculptors = Sculptor.all
    @size = @miniset.sizes.build
    @production = @miniset.productions.build
    @sculpting = @miniset.sculptings.build
  end

  def create
    @miniset = Miniset.new(miniset_params)
    params[:scales][:id].each do |scale|
      if !scale.empty?
        @miniset.sizes.build(:scale_id => scale)
      end
    end
    params[:manufacturers][:id].each do |manufacturer|
      if !manufacturer.empty?
        @miniset.productions.build(:manufacturer_id => manufacturer)
      end
    end
    params[:sculptors][:id].each do |sculptor|
      if !sculptor.empty?
        @miniset.sculptings.build(:sculptor_id => sculptor)
      end
    end
    if @miniset.save
      redirect_to @miniset
    else
      render 'new'
    end
  end

  def update
    @miniset = Miniset.find(params[:id])
    if @miniset.update(miniset_params)
      flash[:success] = "Miniset updated"
      redirect_to @miniset
    else
      render 'edit'
    end
  end

  def index
    @search = Miniset.search(params[:q])
    @search.sorts = 'release_date desc' if @search.sorts.empty?  
    @minisets = @search.result.paginate(page: params[:page])
  end

  def destroy
    Miniset.find(params[:id]).destroy
    flash[:success] = "Set destroyed."
    redirect_to minisets_url
  end


  private
    def miniset_params
      params.require(:miniset).permit(:name, :release_date, :material, :pcode, :notes, :quantity, :random, productions_attributes: [:id, :manufacturer_id, :miniset_id], sizes_attributes: [:id, :scale_id, :miniset_id], sculptings_attributes: [:id, :sculptor_id, :miniset_id])
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
