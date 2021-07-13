class AddFinishDatetimeToEvents < ActiveRecord::Migration[6.0]
  def change
            add_column :events, :finish_datetime, :datetime
  end
end
