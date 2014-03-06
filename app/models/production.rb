class Production < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :miniline
	belongs_to :manufacturer
end
