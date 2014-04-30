class Manufacturer < ActiveRecord::Base
	has_many :lines
	has_many :productions
	has_many :miniatures, :through => :productions
	validates :name, presence: true, length: { maximum: 50 }
	validates :slug, presence: true
	accepts_nested_attributes_for :productions
	has_paper_trail :meta => { :comment => :comment }
	attr_accessor :comment

	def to_param
		slug
	end
end


