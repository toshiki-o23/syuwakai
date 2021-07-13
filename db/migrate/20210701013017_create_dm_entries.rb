class CreateDmEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :dm_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :dm_room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
