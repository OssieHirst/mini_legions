class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :user_id
      t.integer :miniature_id
      t.string :status
      t.string :progress

      t.timestamps
    end
    add_index :collections, [:user_id]
    add_index :collections, [:miniature_id]
    add_index :collections, [:status]
    add_index :collections, [:progress]
    add_index :collections, [:user_id, :miniature_id], unique: true
  end
end
