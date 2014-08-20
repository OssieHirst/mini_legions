class Imagevote < ActiveRecord::Base
	belongs_to :collection, :counter_cache => true
	belongs_to :voter, class_name: "User", :counter_cache => "voted_count"
	belongs_to :voted, class_name: "User", :counter_cache => "vote_count"
	belongs_to :miniature
	validates :collection_id, presence: true
	validates :voter_id, presence: true
	validates :voted_id, presence: true
	validates :miniature_id, presence: true
	validate :cannot_vote_for_self
	after_create :set_gold_and_silver
	after_update :set_gold_and_silver
	
	

	def cannot_vote_for_self
		if voter_id == voted_id
		errors.add(:vote, "You cannot vote for yourself!")
		end
	end

	def set_gold_and_silver
    	self.miniature.set_gold_and_silver
  	end

end
