class CollectionsController < ApplicationController
  before_action :user_signed_in?


  respond_to :html, :js

  def index
    @user = User.find_by_username(params[:user_id])
    @search = @user.collections.where(status: params[:status]).search(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?  
    @collections = @search.result.paginate(page: params[:page])
  end


  def new
    @collection = Collection.new(@miniature)
    @miniature_id = params[:miniature_id]
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
  end

  def create
    @collection = Collection.new(collection_params)
    if @collection.save
      flash[:success] = "Miniature added"
      redirect_to @collection
    else
      flash[:success] = "Did not work!!!"
      render 'new'
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
      params.require(:collection).permit(:user_id, :miniature_id, :status, :progress, :photo, :name, :notes, :video)
    end
end


