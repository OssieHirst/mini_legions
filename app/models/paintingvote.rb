class Paintingvote < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :voter, class_name: "User"
	belongs_to :recipient, class_name: "User"
	belongs_to :collection
	belongs_to :set
	validates :collection_id, presence: true
	validates :voter_id, presence: true
	validates :recipient_id, presence: true	
end
