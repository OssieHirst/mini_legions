module MinilinesHelper

	def mfr_lines(miniature)
		miniature.manufacturers.each do |manufacturer|
			manufacturer.lines
			
		end
	end

end