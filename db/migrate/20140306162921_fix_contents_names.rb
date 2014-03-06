class FixContentsNames < ActiveRecord::Migration
  def change
  	rename_column :contents, :miniature_id, :setmini_id
  end
end
