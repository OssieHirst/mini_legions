class AddDatemaskToMiniatures < ActiveRecord::Migration
  def change
  	add_column :miniatures, :date_mask, :integer, default: "0"
  end
end
