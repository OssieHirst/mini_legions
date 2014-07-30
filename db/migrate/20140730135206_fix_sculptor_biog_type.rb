class FixSculptorBiogType < ActiveRecord::Migration
  def change
  	change_column :sculptors, :biog,  :text
  end
end
