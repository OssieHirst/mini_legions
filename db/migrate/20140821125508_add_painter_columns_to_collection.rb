class AddPainterColumnsToCollection < ActiveRecord::Migration
  def change
  	add_column :collections, :painter, :string, :default => 'owner'
  	add_column :collections, :ml_painter, :integer
  	add_column :collections, :non_ml_painter, :string
  	add_index :collections, :ml_painter
  end
end
