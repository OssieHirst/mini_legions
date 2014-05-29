class SculptorsController < ApplicationController
  before_filter :authenticate_user!
  before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]
  def show
  	@sculptor = Sculptor.find(params[:id])
    @search = @sculptor.miniatures.search(params[:q])
    @search.sorts = 'name ASC' if @search.sorts.empty?  
    @miniatures = @search.result.paginate(page: params[:page])
  end

  def new
    @sculptor = Sculptor.new
  end

  def edit
    @sculptor = Sculptor.find(params[:id])
  end

 def index
    @search = Sculptor.search(params[:q])
    @search.sorts = 'last_name asc' if @search.sorts.empty?  
    @sculptors = @search.result.paginate(page: params[:page])
  end

  def update
    @sculptor = Sculptor.find(params[:id])
     #Add Submission notes
    @sculptor.reload.versions.last.update(comment: params[:comment]) if @sculptor.versions.exists?
    if @sculptor.update_attributes(sculptor_params)
      flash[:success] = "Sculptor updated. #{undo_link}"
      redirect_to @sculptor
    else
      render 'edit'
    end
  end

  def create
    @sculptor = Sculptor.new(sculptor_params)
    if @sculptor.save
      flash[:success] = "Sculptor added. #{undo_link}"
      redirect_to sculptors_path
    else
      render 'new'
    end
  end

  def destroy
    @sculptor = Sculptor.find(params[:id])
    @sculptor.destroy
    flash[:success] = "Sculptor destroyed. #{undo_link}"
    redirect_to sculptors_path
  end

  def admin_user
      if current_user != nil
        redirect_to(root_url) unless current_user.admin?
      else
        redirect_to(root_url)
      end
  end

  private
    def undo_link
      view_context.link_to("undo", revert_version_path(@sculptor.versions.last), :method => :post)
    end
    def sculptor_params
      params.require(:sculptor).permit(:first_name, :last_name, :biog, :comment)
    end
end