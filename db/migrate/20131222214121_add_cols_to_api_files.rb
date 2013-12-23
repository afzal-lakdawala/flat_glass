class AddColsToApiFiles < ActiveRecord::Migration
  def change
    add_column :api_filzs, :data_query_id, :integer
  end
end
