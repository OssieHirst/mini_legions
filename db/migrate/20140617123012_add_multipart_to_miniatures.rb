class AddMultipartToMiniatures < ActiveRecord::Migration
  def change
  	add_column :miniatures, :multipart, :boolean, default: false
  end
end
