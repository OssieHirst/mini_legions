class AddVotecountsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :voted_count, :integer, :default => 0
  	add_column :users, :vote_count, :integer, :default => 0
    add_index :users, :voted_count
    add_index :users, :vote_count
  end
end
