class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name
      t.string :ad_type
      t.text :body
      t.string :channel, default: 'BAIDU', null: false
      t.boolean :published, default: true
      t.timestamps null: false
    end
  end
end
