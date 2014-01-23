class PaintingvotesController < ApplicationController
  before_action :signed_in_user

  respond_to :html, :js

  def new
    @paintingvote = Paintingvote.new(@miniature)
    @miniature_id = params[:miniature_id]
  end

  def destroy
  end
end