class AddSlugToLines < ActiveRecord::Migration
  def change
    add_column :lines, :slug, :string
    add_index :lines, :slug
  end
end
