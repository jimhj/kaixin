class AddBlockColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :block, :boolean, after: :wx_unionid, default: false
  end
end
