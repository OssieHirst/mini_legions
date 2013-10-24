class AddAttachmentPhotoToCollections < ActiveRecord::Migration
  def self.up
    change_table :collections do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :collections, :photo
  end
end
