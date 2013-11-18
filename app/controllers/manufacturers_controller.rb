class ManufacturersController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update]
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
    @manufacturers = Manufacturer.paginate(page: params[:page])
  end

  def create
  end

  def destroy
  end

private
    def manufacturer_params
      params.require(:manufacturer).permit(:name)
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
