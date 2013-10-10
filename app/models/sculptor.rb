class Sculptor < ActiveRecord::Base
	has_many :sculptings
	has_many :miniatures, :through => :sculptings
	def fullname
  	  "#{first_name} #{last_name}"
    end
end
