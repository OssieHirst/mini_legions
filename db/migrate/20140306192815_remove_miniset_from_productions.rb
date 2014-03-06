class RemoveMinisetFromProductions < ActiveRecord::Migration
  def change
  	remove_index :productions, [:miniset_id]
    remove_index :productions, [:miniset_id, :manufacturer_id]
  	remove_column :productions, :miniset_id
  end
end
