class Sculpting < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :sculptor
	has_paper_trail
end
