class CreateSculptors < ActiveRecord::Migration
  def change
    create_table :sculptors do |t|
      t.string :first_name
      t.string :last_name
      t.string :biog

      t.timestamps
    end
  end
end
