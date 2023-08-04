class AddTaskSortPreferenceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :task_sort_preference, :boolean, default: true
  end
end
