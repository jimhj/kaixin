class AddCoverColumnToTag < ActiveRecord::Migration
  def change
    add_column :tags, :cover, :string, after: :name
    add_column :tags, :slug, :string, after: :cover
  end
end
