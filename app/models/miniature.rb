class Miniature < ActiveRecord::Base
  has_many :collections, dependent: :destroy
  has_many :users, :through => :collections
  has_many :productions, dependent: :destroy
  has_many :manufacturers, :through => :productions
  has_many :sizes, dependent: :destroy
  has_many :scales, :through => :sizes
  has_many :sculptings, dependent: :destroy
  has_many :sculptors, :through => :sculptings
  has_many :minilines, dependent: :destroy
  has_many :lines, :through => :minilines
  has_many :paintingvotes, dependent: :destroy
  accepts_nested_attributes_for :productions, allow_destroy: true
  accepts_nested_attributes_for :sizes, allow_destroy: true
  accepts_nested_attributes_for :sculptings, allow_destroy: true
  accepts_nested_attributes_for :minilines, allow_destroy: true
	validates :name, presence: true, length: { maximum: 50 }
	validates :material, presence: true
	validates_date :release_date, :allow_blank => true
  letsrate_rerateable "sculpt", "ingame"

  def name=(s)
    super s.titleize
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Miniature.create! row.to_hash
    end
  end

end