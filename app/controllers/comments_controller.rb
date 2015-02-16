class CommentsController < ApplicationController
	before_filter :load_commentable
	before_action :user_signed_in?, only: [:create, :destroy]

  def create
  	@comment = @commentable.comments.new(comment_params)
  	if @comment.save
  		 flash[:success] = 'Comment posted!' 
      redirect_to @commentable
    else 
      flash[:notice] = "Error creating comment: #{@comment.errors}" 
      redirect_to @commentable
    end 
  end 

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted."
    redirect_to :back
  end

  private

  	def load_commentable
  		resource, id = request.path.split('/')[1, 2]
  		@commentable = resource.singularize.classify.constantize.find(id)
	end

	def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type, :user_id)
  end

end
