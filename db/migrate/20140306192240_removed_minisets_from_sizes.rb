class RemovedMinisetsFromSizes < ActiveRecord::Migration
  def change
  	remove_index :sizes, [:miniset_id]
    remove_index :sizes, [:miniset_id, :scale_id]
  	remove_column :sizes, :miniset_id
  end
end
