class AddLevelToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :level, :integer
  end
end
