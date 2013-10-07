class RemoveMiniatureIdFromManufacturers < ActiveRecord::Migration
  def change
    remove_column :manufacturers, :miniature_id, :integer
  end
end
