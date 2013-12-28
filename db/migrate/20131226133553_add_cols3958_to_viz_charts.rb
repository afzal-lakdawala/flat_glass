class AddCols3958ToVizCharts < ActiveRecord::Migration
  def change
    add_column :viz_charts, :description, :text
  end
end
