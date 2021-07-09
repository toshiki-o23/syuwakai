class RenameStartDatetimeColumnToEvents < ActiveRecord::Migration[6.0]
  def change
    rename_column :events, :start_datetime, :start_time
    rename_column :events, :finish_datetime, :finish_time
  end
end
