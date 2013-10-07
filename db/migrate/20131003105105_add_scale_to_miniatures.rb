class AddScaleToMiniatures < ActiveRecord::Migration
  def change
    add_column :miniatures, :scale, :string
  end
end
