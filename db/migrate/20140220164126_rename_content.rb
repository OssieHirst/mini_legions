class RenameContent < ActiveRecord::Migration
  def change
  	rename_table :content, :contents
  end
end
