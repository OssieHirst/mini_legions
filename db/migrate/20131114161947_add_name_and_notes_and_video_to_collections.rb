class AddNameAndNotesAndVideoToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :name, :string
    add_column :collections, :notes, :string
    add_column :collections, :video, :string
  end
end
