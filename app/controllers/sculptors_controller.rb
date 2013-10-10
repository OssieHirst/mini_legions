class SculptorsController < ApplicationController
  def show
  	@sculptor = Sculptor.find(params[:id])
  end
end