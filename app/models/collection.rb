class Collection < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :user
	validates :user_id, presence: true
	validates :miniature_id, presence: true
	validates :status, presence: true
	validates :progress, presence: true

	has_attached_file :photo, :styles => { :small => "500x500>" }
	:url  => "/assets/collections/:user_id/:id/:style/:basename.:extension",
    :path => ":rails_root/public/assets/collections/:user_id/:id/:style/:basename.:extension"

end
