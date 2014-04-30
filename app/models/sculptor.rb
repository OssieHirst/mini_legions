class Sculptor < ActiveRecord::Base
	has_many :sculptings
	has_many :miniatures, :through => :sculptings
	has_paper_trail :meta => { :comment => :comment }
	default_scope :order => 'last_name ASC, first_name ASC'
	attr_accessor :comment

	def fullname
  	  "#{first_name} #{last_name}"
    end

    def initial_fullname
    	"#{first_name[0,1]}. #{last_name}"
    end
end
