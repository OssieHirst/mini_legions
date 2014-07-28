class Miniline < ActiveRecord::Base
	default_scope { order('name ASC') }
	belongs_to :miniature
	belongs_to :line
end
