module MiniaturesHelper
	def content_miniset_links_with_quantity(miniature)
  		miniature.contents.map{|content| content_miniset_link_with_quantity(content)}.join(', ').html_safe
	end

	def content_miniset_link_with_quantity(content)
  		string = link_to content.miniset.name, content.miniset
  		string << " (x#{content.quantity})" if content.quantity.present?
  		return string
	end

	def content_setmini_links_with_quantity(miniature)
  		miniature.reverse_contents.map{|content| content_setmini_link_with_quantity(content)}.join(' ').html_safe
	end

	def content_setmini_link_with_quantity(content)
      string = (tag "td"), (link_to top_pic(content), content.setmini), (link_to content.setmini.name, content.setmini)
      string << " x#{content.quantity}" if content.quantity.present?
      string <<  delete_link(content) if user_signed_in? && current_user.admin
      return string 
  end

  def top_pic(content)
      @miniature = Miniature.find(content.setmini)
      if @miniature.collections.where("photo_file_name IS NOT NULL").any? == false && @miniature.unpainted.blank?
        image_tag("https://s3.amazonaws.com/minilegions/system/stock/barbarian.gif", :retina => true, :class => "curvediconminiset")
      elsif @miniature.collections.where("photo_file_name IS NOT NULL").any?
        image_tag(@miniature.collections.where("photo_file_name IS NOT NULL").order(imagevotes_count: :desc).first.photo.url(:icon), :retina => true, :class => "curvediconminiset")
      elsif @miniature.unpainted? && @miniature.collections.where("photo_file_name IS NOT NULL").any? == false
        image_tag(@miniature.unpainted.url(:icon), :class => "curvediconminiset")
      end
  end

  def delete_link(content)
    link_to '<i class="fa fa-times"></i>'.html_safe, content_path(content),
            :confirm => 'Are you sure you want to remove this miniature from this set?', :method => :delete 
  end

  	
end
