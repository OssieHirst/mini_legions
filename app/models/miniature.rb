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
  scope :indiv, -> { where(set: false) }
  scope :multi, -> { where(set: true) }
  PartialDate = Struct.new(:year, :month, :day)
  has_paper_trail :meta => { :comment => :comment }
  attr_accessor :comment

  has_attached_file :unpainted,  :styles => { 
    :original => "1024x1024", 
    :medium => " ",
    :icon => " " },
    :convert_options => {
    :icon => '-resize "80x64^" +repage -gravity Center -crop "64x64+0-5"', 
    :medium => '-resize "615" +repage -gravity Center -crop "615x615+0+0"'},
    :url => "/system/miniatures/unpainted/:id/:style/mlc_:id.:extension",
    :path => ":rails_root/public/system/miniatures/unpainted/:id/:style/mlc_:id.:extension" 

    validates_attachment_size :unpainted, :less_than => 2.megabytes
    validates_attachment_content_type :unpainted, :content_type => ['image/jpeg', 'image/png']


  
  def name=(s)
    super s.titleize
  end

  def self.import(file)
    CSV.foreach(file.path, :encoding => 'windows-1251:utf-8', headers: true) do |row|
      symbolized_row = row.to_hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      @miniature = Miniature.create symbolized_row.except(:scale_id, :manufacturer_id, :sculptor_id, :sculptor_id2, :sculptor_id3, :sculptor_id4, :sculptor_id5, :line_id)
      @miniature.sizes.create(:scale_id => symbolized_row[:scale_id]) if symbolized_row[:scale_id].present?
      @miniature.productions.create(:manufacturer_id => symbolized_row[:manufacturer_id]) if symbolized_row[:manufacturer_id].present?
      @miniature.sculptings.create(:sculptor_id => symbolized_row[:sculptor_id]) if symbolized_row[:sculptor_id].present? 
      @miniature.sculptings.create(:sculptor_id => symbolized_row[:sculptor_id2]) if symbolized_row[:sculptor_id2].present? 
      @miniature.sculptings.create(:sculptor_id => symbolized_row[:sculptor_id3]) if symbolized_row[:sculptor_id3].present? 
      @miniature.sculptings.create(:sculptor_id => symbolized_row[:sculptor_id4]) if symbolized_row[:sculptor_id4].present? 
      @miniature.sculptings.create(:sculptor_id => symbolized_row[:sculptor_id5]) if symbolized_row[:sculptor_id5].present? 
      @miniature.minilines.create(:line_id => symbolized_row[:line_id]) if symbolized_row[:line_id].present?
    end
  end

  def set_gold_and_silver
    self.collections.update_all(:is_gold => false, :is_silver => false)
    top_collections = self.collections.where('photo_file_name is not null').order(imagevotes_count: :desc).limit(4)
    gold = top_collections.shift 
    gold.update_attribute :is_gold, true if gold
    top_collections.each {|s| s.update_attribute :is_silver, true}
  end

  def release_date_display
    if self.date_mask == 4
      return self.release_date.strftime('%Y')
    elsif self.date_mask == 6
      return self.release_date.strftime('%b %Y')
    else
      return self.release_date.strftime('%d %b %Y')
    end
  end

  def gold
    self.collections.where(is_gold: true)
  end

  def silver
    self.collections.where(is_silver: true)
  end

  def get_date_select_opt
    opt = { :start_year => Date.current.year, :end_year => 1970, include_blank: true }
    if self.date_mask == 0 || self.release_date == nil
      return opt.merge( selected: nil )
    elsif self.date_mask == 6
      date = PartialDate.new(self.release_date.year, self.release_date.month, nil)
      return opt.merge( selected: date)
    elsif self.date_mask == 4
      date = PartialDate.new(self.release_date.year, nil, nil)
      return opt.merge( selected: date)
    else
      return opt
    end
  end


end