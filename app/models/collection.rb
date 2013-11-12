class Collection < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :user
	validates :user_id, presence: true
	validates :miniature_id, presence: true
	validates :status, presence: true
	validates :progress, presence: true
	retina!

	has_attached_file :photo,  :styles => { 
		:original => "1024x1024", 
		:medium => "620x620",
		:icon => " " },
		:retina => true,
		:convert_options => {
    	:icon => '-resize "140x140^" +repage -gravity Center -crop "64x64+0-5"' },
		:url => "/system/collections/photos/:id/:style/mlc_:id.:extension",
  		:path => ":rails_root/public/system/collections/photos/:id/:style/mlc_:id.:extension" 

		validates_attachment_size :photo, :less_than => 4.megabytes
		validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
