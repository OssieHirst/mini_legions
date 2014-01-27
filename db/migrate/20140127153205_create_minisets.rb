class CreateMinisets < ActiveRecord::Migration
  def change
    create_table :minisets do |t|
      t.text :name
      t.string :material
      t.date :release_date
      t.string :pcode
      t.text :notes
      t.integer :quantity

      t.timestamps
    end
    add_index :minisets, [:created_at]
    add_index :minisets, [:release_date]
    add_index :minisets, [:quantity]
  end
end
