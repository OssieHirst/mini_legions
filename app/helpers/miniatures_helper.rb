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
  		string = (tag "td"), (link_to image_tag("/system/stock/barbarian.gif", :retina => true, :class => "curvediconminiset"), content.setmini), (link_to content.setmini.name, content.setmini)
  		string << " x#{content.quantity}" if content.quantity.present?
  		return string
	end

end
