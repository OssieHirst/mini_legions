class Sculpting < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :miniset
	belongs_to :sculptor
end
