class ChangeDataLevelToEvents < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :level, :string
  end
end
