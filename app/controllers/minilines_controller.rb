class MinilinesController < ApplicationController
	before_action :admin_user,     only: [:new, :create, :edit, :update, :destroy]

  def new
    @miniline = Miniline.new(@miniature)
    @miniature = Miniature.find(params[:miniature_id])
    @lines = ancestry_options(Line.where(manufacturer_id: @miniature.manufacturers.pluck(:id)).arrange(:order => 'name')) {|i| "#{'&nbsp; &nbsp;' * i.depth} #{i.name}".html_safe }
  end

  def create
    @miniline = Miniline.new(miniline_params)
    if @miniline.save
      flash[:success] = "Miniature added to product line"
      redirect_to @miniline.miniature
    else
      flash[:success] = "Did not work!!!"
      render 'new'
    end
  end

  def destroy
    Miniline.find_by_miniature_id_and_line_id(params[:miniature_id], params[:line_id]).destroy
    flash[:success] = "Miniature removed from product line."
    redirect_to :back
  end

  def ancestry_options(items, &block)
      return ancestry_options(items){ |i| "#{'&nbsp; &nbsp;' * i.depth} #{i.name}".html_safe } unless block_given?

      result = []
      items.map do |item, sub_items|
        result << [yield(item), item.id]
        #this is a recursive call:
        result += ancestry_options(sub_items, &block)
      end
      result
  end

  def admin_user
      redirect_to(root_url) unless current_user.admin?
  end

    private

    def miniline_params
      params.require(:miniline).permit(:miniature_id, :line_id)
    end

    def undo_link
      view_context.link_to("undo", revert_version_path(@line.versions.scoped.last), :method => :post)
    end

end
