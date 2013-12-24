class CreateVizVizs < ActiveRecord::Migration
  def change
    create_table :viz_vizs do |t|
      t.string :title
      t.integer :data_filz_id
      t.integer :viz_chart_id
      t.text :map
      t.text :mapped_output
      t.text :settings

      t.timestamps
    end
  end
end
