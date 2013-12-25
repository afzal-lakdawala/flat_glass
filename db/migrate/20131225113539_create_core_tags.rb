class CreateCoreTags < ActiveRecord::Migration
  def change
    create_table :core_tags do |t|
      t.integer :account_id
      t.integer :taggable_id
      t.string :taggable_type
      t.string :genre
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
