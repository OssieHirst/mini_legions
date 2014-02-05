class LinesController < ApplicationController
	before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]

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
      flash[:success] = "Line updated. #{undo_link}"
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
      flash[:success] = "Line added. #{undo_link}"
      redirect_to lines_path
    else
      render 'new'
    end
  end

  def destroy
    @line = Line.find_by_slug(params[:id])
    @line.destroy
    flash[:success] = "Line destroyed. #{undo_link}"
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

    def undo_link
      view_context.link_to("undo", revert_version_path(@line.versions.scoped.last), :method => :post)
    end
    def line_params
      params.require(:line).permit(:name, :description, :parent_id, :manufacturer_id,
                                   :slug)
    end

end
