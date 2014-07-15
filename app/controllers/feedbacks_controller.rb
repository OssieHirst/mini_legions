class FeedbacksController < ApplicationController
    before_action :superadmin_user,     only: :index
    respond_to :html, :json
    has_scope :error_bug, :type => :boolean
    has_scope :comment, :type => :boolean
    has_scope :help_me, :type => :boolean
    has_scope :idea_request, :type => :boolean
    has_scope :new_feedback, :type => :boolean
    has_scope :emailed, :type => :boolean
    has_scope :flagged, :type => :boolean
    has_scope :closed, :type => :boolean

    def create
  		@feedback = current_user.feedbacks.build(feedback_params)
    	if @feedback.save
      		flash[:success] = "Feedback fed back!"
      		redirect_to :back
    	end
  	end

    def index
      @search = apply_scopes(Feedback).search(params[:q])
      @search.sorts = 'created_at desc' if @search.sorts.empty?  
      @feedbacks = @search.result.paginate(page: params[:page])
    end

    def update
      @feedback = Feedback.find(params[:id])
      @feedback.update_attributes(feedback_params)
        respond_with @feedback
    end

  	private

    	def feedback_params
      		params.require(:feedback).permit(:user_id, :nature, :content, :url, :status)
    	end
      def superadmin_user
      if current_user != nil
        redirect_to(root_url) unless current_user.superadmin?
      else
        redirect_to(root_url)
      end
   end
end