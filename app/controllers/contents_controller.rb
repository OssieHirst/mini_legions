class ContentsController < ApplicationController
	before_action :admin_user,     only: [:edit, :update, :destroy]
  before_action :contributor_user,     only: [:new, :create]

  def new
    @content = Content.new(@miniature)
    @miniature = Miniature.find(params[:setmini_id])
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      flash[:success] = "Miniature added to set"
      redirect_to @content.setmini
    else
      flash[:success] = "Did not work!!!"
      render 'new'
    end
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end

  def contributor_user
      redirect_to(root_url) unless current_user.contributor?
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    flash[:success] = "Miniature removed from set."
    redirect_to @content.miniset
  end

  def signed_in_user
    unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
    end
  end

  private

    def content_params
      params.require(:content).permit(:miniset_id, :setmini_id, :quantity)
    end

end
