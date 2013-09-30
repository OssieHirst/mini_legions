class CreateMiniatures < ActiveRecord::Migration
  def change
    create_table :miniatures do |t|
      t.string :name
      t.string :material
      t.date :release_date

      t.timestamps
    end
    add_index :miniatures, [:created_at]
    add_index :miniatures, [:release_date]
  end
end
