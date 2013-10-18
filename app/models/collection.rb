class Collection < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :user
	validates :user_id, presence: true
	validates :miniature_id, presence: true
	validates :status, presence: true
	validates :progress, presence: true
end
