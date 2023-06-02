class Task < ApplicationRecord
belongs_to :user
belongs_to :task_template, optional: true
has_many :subtasks

validates :task_title, presence: true
validates :task_deadline, presence: true
validates :importance_status_id, presence: true, numericality: { only_integer: true }, inclusion: { in: [1, 2] }
end
