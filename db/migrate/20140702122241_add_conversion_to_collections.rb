class AddConversionToCollections < ActiveRecord::Migration
  def change
  	add_column :collections, :conversion, :boolean, default: false
  end
end
