class AddVoteCount < ActiveRecord::Migration
  def change
  	add_column :collections, :imagevotes_count, :integer, :default => 0
    add_index :collections, :imagevotes_count
  end
end
