class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions do |t|
      t.integer :miniature_id
      t.integer :manufacturer_id

      t.timestamps
    end
    add_index :productions, [:miniature_id]
    add_index :productions, [:manufacturer_id]
    add_index :productions, [:miniature_id, :manufacturer_id], unique: true
  end
end
