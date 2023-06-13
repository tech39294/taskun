class TaskTemplate < ApplicationRecord
- belongs_to :user
- has_many :tasks
- has_many :subtask_templates

-validates :task_template_title, presence: true
-validates :task_template_deadline, presence: true
end
