class AddVideoColumnToJoke < ActiveRecord::Migration
  def change
    add_column :jokes, :video_url, :string, after: :photos, default: nil
  end
end
