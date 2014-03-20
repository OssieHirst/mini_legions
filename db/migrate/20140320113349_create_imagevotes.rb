class CreateImagevotes < ActiveRecord::Migration
  def change
    create_table :imagevotes do |t|
    	t.integer :collection_id
    	t.integer :voter_id
    	t.integer :voted_id
    end
    add_index :imagevotes, :collection_id
    add_index :imagevotes, :voter_id
    add_index :imagevotes, :voted_id
    add_index :imagevotes, [:collection_id, :voter_id], unique: true
  end
end
