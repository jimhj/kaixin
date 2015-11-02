class AddVideoCoverColumnToJokes < ActiveRecord::Migration
  def change
    add_column :jokes, :video_cover_url, :string, after: :video_url, default: nil
  end
end
