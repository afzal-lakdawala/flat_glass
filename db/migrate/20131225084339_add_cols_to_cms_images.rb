class AddColsToCmsImages < ActiveRecord::Migration
  def change
    add_column :cms_images, :image_file, :text
  end
end
