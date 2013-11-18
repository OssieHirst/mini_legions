class AddSlugToManufacturers < ActiveRecord::Migration
  def change
    add_column :manufacturers, :slug, :string
    add_index :manufacturers, :slug
  end
end
