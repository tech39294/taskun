class CreateSubtasks < ActiveRecord::Migration[6.0]
  def change
    create_table :subtasks do |t|
      t.string :subtask_title, null: false
      t.date :subtask_deadline, null: false
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
