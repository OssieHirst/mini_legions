class RemoveSlugFromLines < ActiveRecord::Migration
  def change
  	remove_column :lines, :slug, :string
  end
end
