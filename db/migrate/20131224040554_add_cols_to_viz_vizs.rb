class AddColsToVizVizs < ActiveRecord::Migration
  def change
    add_column :viz_vizs, :created_by, :integer
    add_column :viz_vizs, :updated_by, :integer
    add_column :viz_vizs, :account_id, :integer
  end
end
