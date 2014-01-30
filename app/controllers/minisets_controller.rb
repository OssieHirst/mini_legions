class MinisetsController < ApplicationController
   before_action :signed_in_user, only: [:new, :create, :edit, :update]
   before_action :admin_user,     only: :destroy

  def show
    @miniset = Miniset.find(params[:id])
  end

  def new
    @miniset = Miniset.new 
    @miniset.productions.build
    @miniset.sizes.build
    @miniset.sculptings.build
  end

  def create
    @miniset = Miniset.new(miniset_params)
    if @miniset.save
      params[:scale_id].split(',').each do |id|
        @miniset.sizes.create(params[:sizes_attributes])
    end
      redirect_to @miniset
    else
      render 'new'
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
