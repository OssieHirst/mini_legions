class Size < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :scale
end
