module MiniaturesHelper
	def miniset_link_with_quantity(miniset)
  		string = link_to content.miniset.name, content.miniset
  		string << "(x#{content.quantity})" if content.quantity.present?
  		return string
end
end
