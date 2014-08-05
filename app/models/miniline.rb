class Miniline < ActiveRecord::Base
	default_scope { select('*').joins(:line).order('lines.name ASC') }
	belongs_to :miniature
	belongs_to :line
end
