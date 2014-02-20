class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :miniset_id
      t.integer :miniature_id
      t.integer :quantity

      t.timestamps
    end
    add_index :contents, [:miniset_id]
    add_index :contents, [:miniature_id]
    add_index :contents, [:miniset_id, :miniature_id], unique: true
  end
end
