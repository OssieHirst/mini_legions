class DropMinisets < ActiveRecord::Migration
  def change
  	drop_table :minisets
  end
end
