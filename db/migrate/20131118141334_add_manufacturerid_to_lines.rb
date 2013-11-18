class AddManufactureridToLines < ActiveRecord::Migration
  def change
    add_column :lines, :manufacturer_id, :integer
    add_index :lines, :manufacturer_id
  end
end
