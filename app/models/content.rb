class Content < ActiveRecord::Base
	default_scope joins(:setmini).order('miniatures.name ASC').readonly(false)
	belongs_to :miniset, class_name: "Miniature"
	belongs_to :setmini, class_name: "Miniature"
	validates :miniset_id, presence: true
	validates :setmini_id, presence: true
end
