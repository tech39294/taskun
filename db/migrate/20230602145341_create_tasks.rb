class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.date :task_deadline, null: false
      t.string :task_title, null: false      
      t.integer :importance_status_id, null: false
      t.text :memo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
