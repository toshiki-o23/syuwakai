class AddFeeToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :fee, :integer
  end
end
