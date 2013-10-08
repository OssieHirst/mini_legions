class CreateSizes < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.integer :miniature_id
      t.integer :scale_id

      t.timestamps
    end
    add_index :sizes, [:miniature_id]
    add_index :sizes, [:scale_id]
  end
end
