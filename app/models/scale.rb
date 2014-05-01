class Scale < ActiveRecord::Base
	has_many :sizes
	has_many :miniatures, :through => :sizes
	default_scope order('name asc')
end
