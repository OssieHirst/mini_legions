class ImagevotesController < ApplicationController
	
	respond_to :html, :js

	def new
		@imagevote = Imagevote.new
		@miniature = Miniature.find(params[:miniature_id])
	end

	def edit
    	@imagevote = Imagevote.find_by_miniature_id_and_voter_id(params[:miniature_id],params[:voter_id]) 
    	@miniature = Miniature.find(params[:miniature_id]) 
    end

	def create
  		@imagevote = Imagevote.new(imagevote_params)
  		if @imagevote.save
  			flash[:success] = "Vote registered"
  			redirect_to :back
  		else
  			flash[:success] = "Vote not registered"
  			redirect_to :back
  		end
	end

	def update
		@imagevote = Imagevote.find(params[:id])
		if @imagevote.update_attributes(imagevote_params)
			flash[:success] = "Vote changed."
      		redirect_to :back
    	else
      		redirect_to :back
    	end
  	end

	private

    def imagevote_params
      params.require(:imagevote).permit(:collection_id, :voter_id, :voted_id, :miniature_id)
    end
end