class CreateCmsImages < ActiveRecord::Migration
  def change
    create_table :cms_images do |t|
      t.integer :account_id
      t.integer :created_by
      t.integer :updated_by
      t.string :image_file_name
      t.string :image_file_size
      t.string :image_content_type
      t.string :slug
      t.timestamps
    end
  end
end
