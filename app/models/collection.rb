class Collection < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :user
	validates :user_id, presence: true
	validates :miniature_id, presence: true
	validates :status, presence: true
	validates :progress, presence: true

	has_attached_file :photo, :styles => { 
		:original => "2048x2048", 
		:medium => "620x620" }

end
