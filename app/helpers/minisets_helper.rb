module MinisetsHelper

	def content_miniature_links_with_quantity(miniset)
  		miniset.contents.map{|content| content_miniature_link_with_quantity(content)}.join(' ').html_safe
	end

	def content_miniature_link_with_quantity(content)
  		string = (tag "td"), (link_to image_tag("/system/stock/barbarian.gif", :retina => true, :class => "curvediconminiset"), content.miniature), (link_to content.miniature.name, content.miniature)
  		string << " x#{content.quantity}" if content.quantity.present?
  		return string
	end
end
