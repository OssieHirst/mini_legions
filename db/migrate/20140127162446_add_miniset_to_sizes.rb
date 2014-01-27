class AddMinisetToSizes < ActiveRecord::Migration
  def change
  	add_column :sizes, :miniset_id, :integer
  	add_index :sizes, [:miniset_id]
    add_index :sizes, [:miniset_id, :scale_id], unique: true
  end
end
