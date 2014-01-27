class AddIndexToProductions < ActiveRecord::Migration
  def change
  end
  add_index :productions, [:miniset_id]
  add_index :productions, [:miniset_id, :manufacturer_id], unique: true
end
