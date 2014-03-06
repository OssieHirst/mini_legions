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
  has_many :minilines, dependent: :destroy
  has_many :paintingvotes, dependent: :destroy
  has_many :contents, foreign_key: "setmini_id", dependent: :destroy
  has_many :minisets, :through => :contents, source: :miniset
  has_many :reverse_contents, foreign_key: "miniset_id", class_name: "Content", dependent: :destroy
  has_many :setminis, :through => :reverse_contents, source: :setmini
  accepts_nested_attributes_for :productions, allow_destroy: true
  accepts_nested_attributes_for :sizes, allow_destroy: true
  accepts_nested_attributes_for :sculptings, allow_destroy: true
  accepts_nested_attributes_for :minilines, allow_destroy: true
	validates :name, presence: true, length: { maximum: 50 }
	validates :material, presence: true
	validates_date :release_date, :allow_blank => true
  
  def name=(s)
    super s.titleize
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Miniature.create! row.to_hash
    end
  end

end