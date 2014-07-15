class FixFeedbackColumnName < ActiveRecord::Migration
  def change
  	rename_column :feedbacks, :type, :nature
  end
end
