class CreateCmsArticles < ActiveRecord::Migration
  def change
    create_table :cms_articles do |t|
      t.integer :account_id
      t.string :title
      t.text :description
      t.date :published_at
      t.boolean :is_published
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
