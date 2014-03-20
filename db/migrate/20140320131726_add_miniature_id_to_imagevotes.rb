class AddMiniatureIdToImagevotes < ActiveRecord::Migration
  def change
  	add_column :imagevotes, :miniature_id, :integer
  	add_index :imagevotes, :miniature_id
  	add_index :imagevotes, [:miniature_id, :voter_id], unique: true
  	remove_index :imagevotes, [:collection_id, :voter_id]
  end
end
