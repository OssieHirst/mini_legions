class ManufacturersController < ApplicationController
	before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]

  def show
    @manufacturer = Manufacturer.find_by_slug(params[:id])
    @search = @manufacturer.miniatures.search(params[:q])
    @search.sorts = 'name ASC' if @search.sorts.empty?  
    @miniatures = @search.result.paginate(page: params[:page])
  end

  def edit
    @manufacturer = Manufacturer.find_by_slug(params[:id])
  end

  def update
    @manufacturer = Manufacturer.find_by_slug(params[:id])
    #Add Submission notes
    @manufacturer.reload.versions.last.update(comment: params[:comment]) if @manufacturer.versions.exists?
    if @manufacturer.update_attributes(manufacturer_params)
      flash[:success] = "Manufacturer updated. #{undo_link}"
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
      flash[:success] = "Manufacturer added. #{undo_link}"
      redirect_to manufacturers_path
    else
      render 'new'
    end
  end

  def new
    @manufacturer = Manufacturer.new
  end

  def destroy
    @manufacturer = Manufacturer.find_by_slug(params[:id])
    @manufacturer.destroy
    flash[:success] = "Manufacturer destroyed. #{undo_link}"
    redirect_to manufacturers_url
  end

private
    def manufacturer_params
      params.require(:manufacturer).permit(:name, :slug, :description, :comment)
    end

    def admin_user
      if current_user != nil
        redirect_to(root_url) unless current_user.admin?
      else
        redirect_to(root_url)
      end
    end

    def undo_link
      view_context.link_to("undo", revert_version_path(@manufacturer.versions.last), :method => :post)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
end
