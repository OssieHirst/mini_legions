class AddSelfPaintedAndPainterNameToCollection < ActiveRecord::Migration
  def change
  	add_column :collections, :self_painted, :boolean, default: true
  	add_column :collections, :painter_name, :string
  end
end
