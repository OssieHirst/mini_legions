class AddMinisetIdToProductions < ActiveRecord::Migration
  def change
  	add_column :productions, :miniset_id, :integer
  end
  
end
