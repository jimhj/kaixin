class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.belongs_to :commentable, polymorphic: true, index: true
      t.integer :up_votes_count, default: 0
      t.text :body
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
