class LinesController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update]
	before_action :admin_user,     only: :destroy

  def show
    @line = Line.find_by_slug(params[:id])
  end
  def new
    @line = Line.new
  end

  def edit
    @line = Line.find_by_slug(params[:id])
  end

  def update
    @line = Line.find_by_slug(params[:id])
    if @line.update_attributes(line_params)
      flash[:success] = "Line updated"
      redirect_to @line
    else
      render 'edit'
    end
  end

  def index
    @lines = Line.paginate(page: params[:page])
  end

  def create
    @line = Line.new(line_params)
    if @line.save
      flash[:success] = "Line added!"
      redirect_to lines_path
    else
      render 'new'
    end
  end

  def destroy
    Line.find_by_slug(params[:id]).destroy
    flash[:success] = "Line destroyed."
    redirect_to lines_path
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    private
    def line_params
      params.require(:line).permit(:name, :description, :parent_id, :manufacturer_id,
                                   :slug)
    end

end
