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
  end

  def create
    @miniature = Miniature.new(miniature_params)
    @production = @miniature.productions.build
    @size = @miniature.sizes.build
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
    if @miniature.update_attributes(miniature_params)
      flash[:success] = "Miniature updated"
      redirect_to @miniature
    else
      render 'edit'
    end
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
      params.require(:miniature).permit(:name, :release_date, :material, productions_attributes: [:id, :manufacturer_id], sizes_attributes: [:id, :scale_id])
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
