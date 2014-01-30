class RemovePasswordDigestFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :password_digest, :string
  	remove_column :users, :remember_token, :string
  end
end
