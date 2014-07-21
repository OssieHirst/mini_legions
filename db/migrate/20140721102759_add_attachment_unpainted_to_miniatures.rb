class AddAttachmentUnpaintedToMiniatures < ActiveRecord::Migration
  def self.up
    change_table :miniatures do |t|
      t.attachment :unpainted
    end
  end

  def self.down
    drop_attached_file :miniatures, :unpainted
  end
end
