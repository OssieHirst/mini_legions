class StaticPagesController < ApplicationController
  
  def home
    if user_signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @miniatures = Miniature.all(params[:id])
      @users = User.all(params[:id])
      @manufacturers = Manufacturer.all(params[:id])
      @sculptors = Sculptor.all(params[:id])
      @collections = Collection.all(params[:id])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
