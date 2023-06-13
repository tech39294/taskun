class CreateTaskTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :task_templates do |t|
      t.date :task_template_deadline, null: false
      t.string :task_template_title, null: false      
      t.references :user, null: false, foreign_key: truera
      t.timestamps
    end
  end
end
