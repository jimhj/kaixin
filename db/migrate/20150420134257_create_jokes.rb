class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
