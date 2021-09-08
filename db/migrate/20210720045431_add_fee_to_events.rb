class AddFeeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :max_fee, :integer
    add_column :events, :min_fee, :integer
  end
end
