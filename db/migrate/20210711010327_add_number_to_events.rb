class AddNumberToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :number, :integer
  end
end
