class AddYoutubeUrlToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :youtube_url, :string
  end
end
