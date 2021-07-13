class RenameDatetimeColumnToEvents < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :datetime, :start_datetime
  end
end
