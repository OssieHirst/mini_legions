class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
      t.string :description
      t.string :ancestry

      t.timestamps
    end
    add_index :lines, :ancestry
  end
end
