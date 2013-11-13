class AddIndexToMicroposts < ActiveRecord::Migration
  def change
  	add_index :microposts, :reply_to
  end
end
