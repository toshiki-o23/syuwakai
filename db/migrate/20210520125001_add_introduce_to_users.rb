class AddIntroduceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :introduce, :string
  end
end
