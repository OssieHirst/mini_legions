class AddMinisetToSculptings < ActiveRecord::Migration
  def change
  	add_column :sculptings, :miniset_id, :integer
  	add_index :sculptings, [:miniset_id]
    add_index :sculptings, [:miniset_id, :sculptor_id], unique: true
  end
end
