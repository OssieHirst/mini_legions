class Manufacturer < ActiveRecord::Base
	has_many :productions
	has_many :miniatures, :through => :productions
	validates :name, presence: true, length: { maximum: 50 }
	accepts_nested_attributes_for :productions
end


