class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.integer :miniature_id
      t.string :manufacturer

      t.timestamps
    end
    add_index :manufacturers, [:miniature_id]
  end
end
