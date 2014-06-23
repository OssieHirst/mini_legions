class Collection < ActiveRecord::Base
	default_scope { order('imagevotes_count DESC') }
	belongs_to :miniature
	belongs_to :user
    has_many :imagevotes, dependent: :destroy
	validates :user_id, presence: true
	validates :miniature_id, presence: true
	validates :status, presence: true
	validates :progress, presence: true
	validates :name, length: { maximum: 25 }
	validates :notes, length: { maximum: 280 }
	scope :desc, -> { order("photo_updated_at DESC") }
	retina!
	before_destroy :cache_miniature
	after_destroy :set_gold_and_silver

	has_attached_file :photo,  :styles => { 
		:original => "1024x1024", 
		:medium => "615x615",
		:thumb => "205x205",
		:icon => " " },
		:convert_options => {
    	:icon => '-resize "140x140^" +repage -gravity Center -crop "64x64+0-5"'},
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
