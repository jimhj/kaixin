class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :device
      t.belongs_to :auditor
      t.string :title
      t.text :content
      t.text :photos
      t.string :ip
      t.boolean :anonymous, default: false
      t.integer :up_votes_count, default: 0
      t.integer :down_votes_count, default: 0
      t.integer :comments_count, default: 0
      t.float :hot, default: 0.0
      t.integer :status, index: true
      t.datetime :approved_at
      t.datetime :rejected_at
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
