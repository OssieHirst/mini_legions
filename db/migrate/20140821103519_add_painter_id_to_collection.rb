class AddPainterIdToCollection < ActiveRecord::Migration
  def change
  	add_column :collections, :painter_id, :integer
  	add_index :collections, :painter_id
  end
end
