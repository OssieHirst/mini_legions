class AddIndexToProductionsMiniatureId < ActiveRecord::Migration
  def change
  	add_index :productions, [:miniature_id, :manufacturer_id], unique: true
  end
end
