class CreateEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :evaluations do |t|
      t.text :comment
      t.integer :evaluation
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
    add_index :evaluations, [:event_id, :user_id], unique: true
  end
end
