class CreateSculptings < ActiveRecord::Migration
  def change
    create_table :sculptings do |t|
      t.integer :sculptor_id
      t.integer :miniature_id

      t.timestamps
    end
    add_index :sculptings, [:miniature_id]
    add_index :sculptings, [:sculptor_id]
    add_index :sculptings, [:miniature_id, :sculptor_id], unique: true
  end
end
