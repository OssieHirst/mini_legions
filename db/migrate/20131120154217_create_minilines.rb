class CreateMinilines < ActiveRecord::Migration
  def change
    create_table :minilines do |t|
      t.integer :miniature_id
      t.integer :line_id

      t.timestamps
    end
  end
end
