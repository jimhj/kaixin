class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.belongs_to :user, index: true
      t.belongs_to :joke, index: true
      t.string :image, null: false
      t.text :meta
      t.timestamps null: false
    end
  end
end
