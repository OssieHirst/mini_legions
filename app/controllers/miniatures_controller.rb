class MiniaturesController < ApplicationController
  def show
    @miniature = Miniature.find(params[:id])
  end

  def new
  	@miniature = Miniature.new
  end

  def index
  end

  def create
  	@miniature = Miniature.new(miniature_params)
    if @miniature.save
      redirect_to @miniature
    else
      render 'new'
    end
  end

  def destroy
  end

private

    def miniature_params
      params.require(:miniature).permit(:name, :release_date, :material)
    end
end
