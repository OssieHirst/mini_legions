module PaperTrail
  class Version < ActiveRecord::Base
    def user
      User.find self.whodunnit.to_i
    end

    def nextversion
    	self.next
    end
  end
end