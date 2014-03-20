class Imagevote < ActiveRecord::Base
	belongs_to :collection
	belongs_to :voter, class_name: "User"
	belongs_to :voted, class_name: "User"
	belongs_to :miniature
	validates :collection_id, presence: true
	validates :voter_id, presence: true
	validates :voted_id, presence: true
	validates :miniature_id, presence: true
	validate :cannot_vote_for_self
	

	def cannot_vote_for_self
		errors.add_to_base('You cannot vote for your self') if :voter_id == :voted_id
	end

end
