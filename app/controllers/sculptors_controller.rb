class SculptorsController < ApplicationController
  def show
  	@sculptor = Sculptor.find(params[:id])
  end

  def new
    @sculptor = Sculptor.new
  end

  def edit
    @sculptor = Sculptor.find(params[:id])
  end

 def index
    @search = Sculptor.search(params[:q])
    @sculptors = @search.result.paginate(page: params[:page])
  end

  def create
    @sculptor = Sculptor.new(sculptor_params)
    if @sculptor.save
      flash[:success] = "Sculptor added!"
      redirect_to sculptors_path
    else
      render 'new'
    end
  end

  def update
    @sculptor = Sculptor.find(params[:id])
    if @sculptor.update_attributes(sculptor_params)
      flash[:success] = "Sculptor updated"
      redirect_to @sculptor
    else
      render 'edit'
    end
  end

  def create
    @sculptor = Sculptor.new(sculptor_params)
    if @sculptor.save
      flash[:success] = "Sculptor added!"
      redirect_to sculptors_path
    else
      render 'new'
    end
  end

  def destroy
    Sculptor.find(params[:id]).destroy
    flash[:success] = "Sculptor destroyed."
    redirect_to sculptors_path
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end

  private
    def sculptor_params
      params.require(:sculptor).permit(:first_name, :last_name, :biog)
    end
end