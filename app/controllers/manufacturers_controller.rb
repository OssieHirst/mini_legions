class ManufacturersController < ApplicationController
	before_action :user_signed_in?, only: [:new, :create, :edit, :update]
	before_action :admin_user,     only: :destroy

  def show
    @manufacturer = Manufacturer.find_by_slug(params[:id])
  end

  def edit
    @manufacturer = Manufacturer.find_by_slug(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find_by_slug(params[:id])
    if @manufacturer.update_attributes(manufacturer_params)
      flash[:success] = "Manufacturer updated"
      redirect_to @manufacturer
    else
      render 'edit'
    end
  end

  def index
    @search = Manufacturer.search(params[:q])
    @search.sorts = 'name asc' if @search.sorts.empty?  
    @manufacturers = @search.result.paginate(page: params[:page])
  end

  def create
    @manufacturer = Manufacturer.new(manufacturer_params)
    if @manufacturer.save
      flash[:success] = "Manufacturer added!"
      redirect_to manufacturers_path
    else
      render 'new'
    end
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def destroy
    Manufacturer.find_by_slug(params[:id]).destroy
    flash[:success] = "Manufacturer destroyed."
    redirect_to manufacturers_url
  end

private
    def manufacturer_params
      params.require(:manufacturer).permit(:name, :slug)
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
