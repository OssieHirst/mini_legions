module PaperTrail
  class Version < ActiveRecord::Base
    def user
    	puts "Value of whodunnit is -----------> #{self.whodunnit}"
    	User.find self.whodunnit.to_i
    end
  end
end