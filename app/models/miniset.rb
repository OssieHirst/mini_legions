class Miniset < ActiveRecord::Base
  has_many :users, :through => :collections
  has_many :productions, dependent: :destroy
  has_many :manufacturers, :through => :productions
  has_many :sizes, dependent: :destroy
  has_many :scales, :through => :sizes
  has_many :sculptings, dependent: :destroy
  has_many :sculptors, :through => :sculptings
  has_many :minilines, dependent: :destroy
  has_many :lines, :through => :minilines
  has_many :contents, dependent: :destroy
  has_many :miniatures, :through => :contents
  accepts_nested_attributes_for :productions, allow_destroy: true
  accepts_nested_attributes_for :sizes, allow_destroy: true
  accepts_nested_attributes_for :sculptings, allow_destroy: true
  accepts_nested_attributes_for :minilines, allow_destroy: true
  validates :name, presence: true, length: { maximum: 50 }
#  validates :material, presence: true
  validates :quantity, numericality: true
  validates_date :release_date, :allow_blank => true

  def name=(s)
    super s.titleize
  end
  
end
