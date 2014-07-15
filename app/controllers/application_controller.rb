class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_feedback


  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || root_path
    end
  end

  def set_feedback
    if current_user != nil
      @feedback = current_user.feedbacks.build
    end
  end

  
    protected

   def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :name, :email, :password, :password_confirmation) }  
    devise_parameter_sanitizer.for(:account_update) << :name << :username  
   end
end