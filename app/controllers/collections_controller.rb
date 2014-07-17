class CollectionsController < ApplicationController
  has_scope :got, :type => :boolean
  has_scope :want, :type => :boolean
  has_scope :painted, :type => :boolean
  has_scope :gold, :type => :boolean
  has_scope :silver, :type => :boolean
  respond_to :html, :json

  def index
    @user = User.find_by_username(params[:user_id])
    @search = apply_scopes(@user.collections).search(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?  
    @collections = @search.result.paginate(page: params[:page])
  end

  def new
    @collection = Collection.new(@miniature)
    @miniature_id = params[:miniature_id]
    @miniature = Miniature.find(params[:miniature_id])
  end

  def destroy_original
    File.unlink(self.photo.path)
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(collection_params)
      flash[:notice] = "Successfully updated collection item."
      redirect_to @collection
    else
      flash[:notice] = "That update did not work."
      render @collection
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @miniature = @collection.miniature
    @user = @collection.user
    @micropost  = current_user.microposts.build if user_signed_in?
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      flash[:success] = "Miniature added"
      redirect_to :back
    else
      flash[:success] = "Did not work!!!"
      redirect_to :back
    end
  end

  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy
    if @collection.status == 'Got'
      flash[:success] = "Removed from collection"
      redirect_to user_path(current_user)
    elsif @collection.status == 'Want'
      flash[:success] = "Removed from wantlist"
      redirect_to :back
    end 
  end

  private

    def collection_params
      params.require(:collection).permit(:user_id, :miniature_id, :status, :progress, :photo, :name, :notes, :video, :conversion)
    end
end


