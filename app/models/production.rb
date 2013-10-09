class Production < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :manufacturer
end
