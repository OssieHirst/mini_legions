class RemakeContents < ActiveRecord::Migration
  def change

    create_table :contents do |t|
      t.integer :miniset_id
      t.integer :setmini_id
      t.integer :quantity

      t.timestamps
    end
    add_index :contents, [:miniset_id]
    add_index :contents, [:setmini_id]
    add_index :contents, [:miniset_id, :setmini_id], unique: true
  end
end
