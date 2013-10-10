class AddPcodeAndNotesToMiniature < ActiveRecord::Migration
  def change
    add_column :miniatures, :pcode, :string
    add_column :miniatures, :notes, :string
  end
end
