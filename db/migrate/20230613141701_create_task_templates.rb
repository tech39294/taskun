class CreateTaskTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :task_templates do |t|
      t.integer :task_days, null: false
      t.string :task_template_title, null: false      
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
