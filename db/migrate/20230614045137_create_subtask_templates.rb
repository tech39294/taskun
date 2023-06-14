class CreateSubtaskTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :subtask_templates do |t|

      t.timestamps
    end
  end
end
