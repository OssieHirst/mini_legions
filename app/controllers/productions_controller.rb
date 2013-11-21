class ProductionsController < ApplicationController

  def create
    @production = Production.new(production_params)
  end

  def params
  	@params
  end

  def update
    @production = Production.find(params[:id])
  end

end