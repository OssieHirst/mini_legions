class ContentsController < ApplicationController
	before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]

  def new
    @content = Content.new(@miniature)
    @miniature = Miniature.find(params[:miniature_id])
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      flash[:success] = "Miniature added to set"
      redirect_to @content.miniature
    else
      flash[:success] = "Did not work!!!"
      render 'new'
    end
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

  private

    def content_params
      params.require(:content).permit(:miniset_id, :miniature_id, :quantity)
    end

end