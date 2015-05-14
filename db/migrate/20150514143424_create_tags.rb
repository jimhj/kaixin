class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, null: false, unique: true
      t.string :seo_title
      t.string :seo_keywords
      t.string :seo_description
      t.integer :taggings_count, default: 0
      t.timestamps null: false
    end
  end
end
