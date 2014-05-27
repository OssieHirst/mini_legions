class Production < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :miniline
	belongs_to :manufacturer
	has_paper_trail 
end
