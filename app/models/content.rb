class Content < ActiveRecord::Base
	belongs_to :miniset
	belongs_to :miniature
	validates :miniset_id, presence: true
	validates :miniature_id, presence: true
end
