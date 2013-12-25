class AddCols39490ToCmsImages < ActiveRecord::Migration
  def change
    add_column :cms_images, :title, :string
  end
end
