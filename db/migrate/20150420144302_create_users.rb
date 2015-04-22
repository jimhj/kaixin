class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :password_digest, null: false      
      t.string :mobile
      t.text :bio
      t.string :avatar
      t.boolean :confirmed, default: false
      
      t.integer  :sign_in_count, default: 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip 
      
      # 第三方登录
      t.string :weibo_token
      t.string :weibo_uid
      t.string :qq_token
      t.string :qq_uid
      t.string :wx_token
      t.string :wx_uid

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :login, unique: true
  end
end
