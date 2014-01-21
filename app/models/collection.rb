class Collection < ActiveRecord::Base
	belongs_to :miniature
	belongs_to :user
	validates :user_id, presence: true
	validates :miniature_id, presence: true
	validates :status, presence: true
	validates :progress, presence: true
	validates :name, length: { maximum: 25 }
	validates :notes, length: { maximum: 280 }
	retina!

	has_attached_file :photo,  :styles => { 
		:original => "1024x1024", 
		:medium => "615x615",
		:thumb => "205x205#",
		:icon => " " },
		:convert_options => {
    	:icon => '-resize "140x140^" +repage -gravity Center -crop "64x64+0-5"' },
    	:retina => true,
		:url => "/system/collections/photos/:id/:style/mlc_:id.:extension",
  		:path => ":rails_root/public/system/collections/photos/:id/:style/mlc_:id.:extension" 

		validates_attachment_size :photo, :less_than => 4.megabytes
		validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
end
