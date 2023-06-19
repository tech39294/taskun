class CreateSubtasks < ActiveRecord::Migration[6.0]
  def change
    create_table :subtasks do |t|
      t.string :subtask_title, null: true
      t.date :subtask_deadline, null: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
