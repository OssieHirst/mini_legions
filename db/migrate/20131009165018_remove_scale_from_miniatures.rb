class RemoveScaleFromMiniatures < ActiveRecord::Migration
  def change
    remove_column :miniatures, :scale, :string
  end
end
