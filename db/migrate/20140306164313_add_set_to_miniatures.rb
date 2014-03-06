class AddSetToMiniatures < ActiveRecord::Migration
  def change
  	add_column :miniatures, :set, :boolean, default: false
  	add_column :miniatures, :random, :boolean, default: false
  	add_column :miniatures, :quantity, :integer
  end
end
