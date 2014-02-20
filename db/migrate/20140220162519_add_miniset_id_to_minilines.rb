class AddMinisetIdToMinilines < ActiveRecord::Migration
  def change
  	add_column :minilines, :miniset_id, :integer
  	add_index :minilines, [:miniset_id]
  	add_index :minilines, [:miniset_id, :line_id], unique: true
  end
end