class CollectionsController < ApplicationController
  before_action :signed_in_user

  respond_to :html, :js

  def create
    @collection = @miniature.collections.build
    current_user.add!(@miniature)
    if @collection.save
      redirect_to @miniature
    end
  end

  def destroy
    @miniature = Collection.find(params[:id]).remove
    current_user.remove!(@miniature)
    redirect_to @miniature
  end
end
