class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :joke, index: true
      t.belongs_to :tag, index: true
      t.string :context, limit: 128
      t.datetime :created_at
    end

    add_index :taggings, [:joke_id, :tag_id]
  end
end
