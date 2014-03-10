module ManufacturersHelper

	def line_sublink_with_count(line)
  		string = link_to line.name, line
  		string << " (#{Miniature.uniq.joins(:lines).where(line.subtree_conditions).count})" if Miniature.uniq.joins(:lines).where(line.subtree_conditions).any?
  		return string
	end

end
