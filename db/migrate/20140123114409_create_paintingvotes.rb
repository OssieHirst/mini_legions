class CreatePaintingvotes < ActiveRecord::Migration
  def change
    create_table :paintingvotes do |t|
      t.integer :miniature_id
      t.integer :set_id
      t.integer :collection_id
      t.integer :voter_id
      t.integer :recipient_id

      t.timestamps
    end
     add_index :paintingvotes, :miniature_id
     add_index :paintingvotes, :set_id
     add_index :paintingvotes, :collection_id
     add_index :paintingvotes, :voter_id
     add_index :paintingvotes, :recipient_id
     add_index :paintingvotes, [:miniature_id, :voter_id], unique: true
  end
end
