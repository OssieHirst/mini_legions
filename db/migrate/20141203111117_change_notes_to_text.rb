class ChangeNotesToText < ActiveRecord::Migration
  def change
  	change_column :miniatures, :notes, :text, :limit => nil
  end
end
