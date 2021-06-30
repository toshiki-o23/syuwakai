class AddContentToRoom < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :content, :text
  end
end
