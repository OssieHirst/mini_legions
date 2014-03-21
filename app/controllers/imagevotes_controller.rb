class ImagevotesController < ApplicationController
	
	respond_to :html, :js

	def new
		@imagevote = Imagevote.new
		@miniature = Miniature.find(params[:miniature_id])
	end

	def show
    	@imagevote = Imagevote.find(params[:id]) 
      @miniature = @imagevote.miniature
  end

  def edit
      @imagevote = Imagevote.find_by_miniature_id_and_voter_id(params[:miniature_id],params[:voter_id]) 
      @miniature = Miniature.find(params[:miniature_id]) 
  end

	def create
  		@imagevote = Imagevote.new(imagevote_params)
  		@collection = Collection.find(params[:imagevote][:collection_id])
  		@imagevote.voted_id = @collection.user_id
  		if @imagevote.save
  			flash[:success] = "Vote accepted."
  			redirect_to @imagevote
  		else
  			flash[:alert] = "Vote not accepted."
        flash[:alert] << @imagevote.errors[:vote].first unless @imagevote.errors[:vote].nil?
  			redirect_to :back
  		end
	end

	def update
		@imagevote = Imagevote.find(params[:id])
		@collection = Collection.find(params[:imagevote][:collection_id])
  		@imagevote.voted_id = @collection.user_id
		if @imagevote.update_attributes(imagevote_params)
			flash[:success] = "Vote changed."
      		redirect_to @imagevote
    	else
        flash[:alert] = "Vote not accepted. "
        flash[:alert] << @imagevote.errors[:vote].first unless @imagevote.errors[:vote].nil?
      		redirect_to :back
    	end
  	end

	private

    def imagevote_params
      params.require(:imagevote).permit(:collection_id, :voter_id, :miniature_id)
    end
end