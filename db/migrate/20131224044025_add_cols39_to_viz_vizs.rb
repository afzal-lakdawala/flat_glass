class AddCols39ToVizVizs < ActiveRecord::Migration
  def change
    add_column :viz_vizs, :slug, :string
  end
end
