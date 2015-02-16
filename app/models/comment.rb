class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
	belongs_to :user
	validates :content, presence: true, length: { maximum: 2000 }
	validates :user_id, presence: true
	validates :commentable_id, presence: true
	validates :commentable_type, presence: true

	#Comment some more
end
