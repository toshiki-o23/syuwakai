class CreateDmMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :dm_messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dm_room, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
