class CreateSubtaskTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :subtask_templates do |t|
      t.integer :subtask_template_days, null: false
      t.string :subtask_template_title, null: false
      t.references :task_template, null: false, foreign_key: true
      t.timestamps
    end
  end
end
