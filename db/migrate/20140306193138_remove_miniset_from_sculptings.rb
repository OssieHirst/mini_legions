class RemoveMinisetFromSculptings < ActiveRecord::Migration
  def change
  	remove_index :sculptings, [:miniset_id]
    remove_index :sculptings, [:miniset_id, :sculptor_id]
  	remove_column :sculptings, :miniset_id  
  end
end
