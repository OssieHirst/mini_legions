class ImagevotesController < ApplicationController
	
	respond_to :html, :js

	def new
		@imagevote = Imagevote.new
		@miniature = Miniature.find(params[:miniature_id])
	end

	def show
    	@imagevote = Imagevote.find_by_miniature_id_and_voter_id(params[:miniature_id],params[:voter_id]) 
    	@miniature = Miniature.find(params[:miniature_id]) 
    end

	def create
  		@imagevote = Imagevote.new(imagevote_params)
  		@collection = Collection.find(params[:imagevote][:collection_id])
  		@imagevote.voted_id = @collection.user_id
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
		@collection = Collection.find(params[:imagevote][:collection_id])
  		@imagevote.voted_id = @collection.user_id
		if @imagevote.update_attributes(imagevote_params)
			flash[:success] = "Vote changed."
      		redirect_to :back
    	else
      		redirect_to :back
    	end
  	end

	private

    def imagevote_params
      params.require(:imagevote).permit(:collection_id, :voter_id, :miniature_id)
    end
end