class TaskTemplate < ApplicationRecord
belongs_to :user
has_many :tasks
has_many :subtask_templates
accepts_nested_attributes_for :subtask_templates

validates :task_template_title, presence: true
validates :task_template_days, presence: true
end
