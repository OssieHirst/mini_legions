class AddGoldSilverToCollections < ActiveRecord::Migration
  def change
  	add_column :collections, :is_gold, :boolean, default: false
  	add_column :collections, :is_silver, :boolean, default: false
    add_index :collections, :is_gold
    add_index :collections, :is_silver
  end
end
