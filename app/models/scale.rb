class Scale < ActiveRecord::Base
	has_many :sizes
	has_many :miniatures, :through => :sizes
end
