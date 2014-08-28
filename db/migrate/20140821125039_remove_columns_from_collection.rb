class RemoveColumnsFromCollection < ActiveRecord::Migration
  def change
  	remove_column :collections, :painter_name, :string
  	remove_column :collections, :self_painted, :boolean, default: true
  	remove_column :collections, :painter_id, :integer
  end
end
