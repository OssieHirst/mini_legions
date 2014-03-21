class DropPaintingvotes < ActiveRecord::Migration
  def change
  	drop_table :paintingvotes
  end
end
