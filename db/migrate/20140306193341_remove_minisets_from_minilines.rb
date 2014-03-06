class RemoveMinisetsFromMinilines < ActiveRecord::Migration
  def change
  	remove_index :minilines, [:miniset_id]
  	remove_index :minilines, [:miniset_id, :line_id]
  	remove_column :minilines, :miniset_id
  end
end
