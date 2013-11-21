class Miniline < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :line
end
