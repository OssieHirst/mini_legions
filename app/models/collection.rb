class Collection < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :user
    has_many :imagevotes, dependent: :destroy
	validates :user_id, presence: true
	validates :miniature_id, presence: true
	validates :status, presence: true
	validates :progress, presence: true
	validates :name, length: { maximum: 25 }
	validates :notes, length: { maximum: 280 }
	scope :painted, -> { where(progress: 'Painted') }
	scope :got, -> { where(status: 'Got') }
	scope :want, -> { where(status: 'Want') }
	scope :gold, -> { where(is_gold: true) }
	scope :silver, -> { where(is_silver: true) }
	retina!
	before_destroy :cache_miniature
	after_update :set_gold_and_silver
	after_destroy :set_gold_and_silver

	has_attached_file :photo,  :styles => { 
		:original => "1024x1024", 
		:medium => " ",
		:thumb => " ",
		:feed_thumb => " ",
		:icon => " " },
		:convert_options => {
    	:icon => '-resize "80x64^" +repage -gravity Center -crop "64x64+0-5"', 
    	:medium => '-resize "615" +repage -gravity Center -crop "615x615+0+0"', 
    	:thumb => '-resize "205x180^" +repage -gravity Center -crop "205x180+0+0"',
    	:feed_thumb => '-resize "300x180^" +repage -gravity Center -crop "300x180+0+0"'},
    	:retina => true,
		:url => "/system/collections/photos/:id/:style/mlc_:id.:extension",
  		:path => ":rails_root/public/system/collections/photos/:id/:style/mlc_:id.:extension" 

		validates_attachment_size :photo, :less_than => 4.megabytes
		validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']


	def cache_miniature
    	@miniature = self.miniature
  	end

  	def set_gold_and_silver
  		@miniature.set_gold_and_silver
  	end
end
