class AddCols394ToCmsImages < ActiveRecord::Migration
  def change
    add_column :cms_images, :url, :text
    remove_column :cms_images, :image_file_name
  end
end
