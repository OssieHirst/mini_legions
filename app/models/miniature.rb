class Miniature < ActiveRecord::Base
  has_many :productions, dependent: :destroy
  has_many :manufacturers, :through => :productions
  accepts_nested_attributes_for :productions

	validates :name, presence: true, length: { maximum: 50 }
	validates :material, presence: true
	validates :scale, presence: true
	validates_date :release_date, :allow_blank => true

  def name=(s)
    super s.titleize
  end

end