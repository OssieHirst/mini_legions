class VersionsController < ApplicationController
	before_action :admin_user,     only: :index
  def revert
    @version = PaperTrail::Version.find(params[:id])
    if @version.reify
      @version.reify.save!
    else
      @version.item.destroy
    end
    redirect_to Miniature.find(@version.item_id), :notice => "Undid #{@version.event}"
  end

  def index
  	@search = Version.search(params[:q])
  	@search.sorts = 'created_at DESC' if @search.sorts.empty?  
    @versions = @search.result.uniq.paginate(page: params[:page])
  end
  private
  def admin_user
      if current_user != nil
        redirect_to(root_url) unless current_user.admin?
      else
        redirect_to(root_url)
      end
   end

end
