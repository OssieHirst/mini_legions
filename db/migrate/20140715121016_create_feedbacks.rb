class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :type
      t.string :content
      t.string :url
      t.string :status

      t.timestamps
    end
    add_index :feedbacks, [:user_id]
  end
end
