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
  has_many :imagevotes, dependent: :destroy
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
  scope :indiv, where(set: false)
  scope :multi, where(set: true)
  
  def name=(s)
    super s.titleize
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Miniature.create! row.to_hash
    end
  end

  def set_gold_and_silver
    self.collections.update_all(:is_gold => false, :is_silver => false)
    top_collections = self.collections.limit(4)
    gold = top_collections.shift 
    gold.update_attribute :is_gold, true if gold
    top_collections.each {|s| s.update_attribute :is_silver, true}
  end


end