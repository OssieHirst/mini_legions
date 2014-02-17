class LinesController < ApplicationController
	before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]


    def ancestry_options(items, &block)
      return ancestry_options(items){ |i| "#{'&nbsp; &nbsp; &nbsp;' * i.depth} #{i.name}".html_safe } unless block_given?

      result = []
      items.map do |item, sub_items|
        result << [yield(item), item.id]
        #this is a recursive call:
        result += ancestry_options(sub_items, &block)
      end
      result
    end


  def show
    @line = Line.find(params[:id])
  end
  def new
    @line = Line.new
    @lines = ancestry_options(Line.all.arrange(:order => 'name')) {|i| "#{'&nbsp; &nbsp; &nbsp;' * i.depth} #{i.name}".html_safe }
  end

  def edit
    @line = Line.find(params[:id])
  end

  def update
    @line = Line.find(params[:id])
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
    @line = Line.find(params[:id])
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
      params.require(:line).permit(:name, :description, :parent_id, :manufacturer_id)
    end

end
