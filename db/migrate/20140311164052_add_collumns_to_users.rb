class AddCollumnsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :contributor, :boolean, default: false
  	add_column :users, :superadmin, :boolean, default: false
  end
end
