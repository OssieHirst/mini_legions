class AddTimestampsToImagevotes < ActiveRecord::Migration
  def change
  	change_table :imagevotes do |t|
  		t.timestamps
  	end
  end
end
