class Miniline < ActiveRecord::Base
	default_scope { joins(:line).order("lines.name ASC").readonly(false) }
	belongs_to :miniature
	belongs_to :line
end
