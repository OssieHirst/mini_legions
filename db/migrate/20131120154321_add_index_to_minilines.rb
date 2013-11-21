class AddIndexToMinilines < ActiveRecord::Migration
  def change
  	add_index :minilines, :miniature_id
    add_index :minilines, :line_id
    add_index :minilines, [:miniature_id, :line_id], unique: true
  end
end
