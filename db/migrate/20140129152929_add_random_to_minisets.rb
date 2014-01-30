class AddRandomToMinisets < ActiveRecord::Migration
  def change
  	add_column :minisets, :random, :boolean, default: false
  end
end
