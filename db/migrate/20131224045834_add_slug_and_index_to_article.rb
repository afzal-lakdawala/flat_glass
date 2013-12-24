class AddSlugAndIndexToArticle < ActiveRecord::Migration
  def change
    add_column :cms_articles, :slug, :string
    add_index "cms_articles", ["slug"], :name => "index_cms_articles_on_slug"

  end
end
