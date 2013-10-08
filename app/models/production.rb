class Production < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :manufacturer
    validates :miniature_id, presence: true
    validates :manufacturer_id, presence: true


end
