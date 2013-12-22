class CreateApiFiles < ActiveRecord::Migration
  def change
    create_table :api_files do |t|
      t.integer :data_file_id
      t.integer :api_account_id
      t.string :api_account_name
      t.text :error_string
      t.string :status
      t.datetime :last_requested_at
      t.integer :last_requested_by
      t.integer :user_id
      t.integer :account_id

      t.timestamps
    end
  end
end
