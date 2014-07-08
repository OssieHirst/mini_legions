class UsersController < ApplicationController
  before_filter :authenticate_user!   
   before_action :user_signed_in?, only: [:index, :edit, :update, :destroy, :following, :followers]
   before_action :correct_user,   only: [:edit, :update]  
   before_action :admin_user,     only: :destroy

  def show
    @user = User.find_by_username(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
  	@user = User.new
  end

  def index
    @search = User.search(params[:q])
    @search.sorts = 'username asc' if @search.sorts.empty?  
    @users = @search.result.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Mini Legions!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by_username(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find_by_username(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find_by_username(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :username, :password,
                                   :password_confirmation)
    end

    def admin_user
      if current_user != nil
        redirect_to(root_url) unless current_user.admin?
      else
        redirect_to(root_url)
      end
    end

# Before filters

    def correct_user
      @user = User.find_by_username(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end