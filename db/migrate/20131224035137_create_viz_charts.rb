class CreateVizCharts < ActiveRecord::Migration
  def change
    create_table :viz_charts do |t|
      t.string :name
      t.string :genre
      t.text :img
      t.text :mapping

      t.timestamps
    end
  end
end
