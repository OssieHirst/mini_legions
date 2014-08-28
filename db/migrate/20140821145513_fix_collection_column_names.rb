class FixCollectionColumnNames < ActiveRecord::Migration
  def change
  	rename_column :collections, :ml_painter, :ml_painter_id
  	rename_column :collections, :non_ml_painter, :non_ml_painter_name
  end
end
