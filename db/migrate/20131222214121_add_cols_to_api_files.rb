class AddColsToApiFiles < ActiveRecord::Migration
  def change
    add_column :api_files, :data_query_id, :integer
  end
end
