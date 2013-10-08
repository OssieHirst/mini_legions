class Size < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :scale
	validates :miniature_id, presence: true
    validates :scale_id, presence: true
end
