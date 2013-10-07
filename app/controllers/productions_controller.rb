class ProductionsController < ApplicationController

  def create
    @production = Production.new(production_params)
  end

  def params
  	@params
  end

  def update
    @production.update_attributes(production_params)
  end

end