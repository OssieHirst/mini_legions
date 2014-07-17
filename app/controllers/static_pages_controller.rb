class StaticPagesController < ApplicationController
  
  def home
    if user_signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page => 12)
      @miniatures = Miniature.all(params[:id])
      @users = User.all(params[:id])
      @manufacturers = Manufacturer.all(params[:id])
      @sculptors = Sculptor.all(params[:id])
      @lines = Line.all(params[:id])
      @collections = Collection.all(params[:id])
      @imagevotes = Imagevote.all(params[:id])
    end
  end



  def help
  end

  def about
  end

  def contact
  end

  def gallery
    @user = User.find_by_username(params[:user_id])
    @gallery_items = Collection.where('photo_file_name is not null').order("photo_updated_at ASC").paginate(page: params[:page], :per_page => 16)
  end
  
end
