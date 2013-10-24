class CollectionsController < ApplicationController
  before_action :signed_in_user

  respond_to :html, :js

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
    @collection = Collection.create(collection_params)
  end

  def destroy
    @miniature = Collection.find(params[:id]).remove
    current_user.remove!(@miniature)
    redirect_to @miniature
  end

  private

    def collection_params
      params.require(:collection).permit(:user_id, :miniature_id, :status, :progress, :photo)
    end
end


