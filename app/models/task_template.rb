class TaskTemplate < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :subtask_templates
  accepts_nested_attributes_for :subtask_templates

  validates :task_template_title, presence: true
  validates :task_template_days, presence: true

  def self.search(search)
    if search != ''
      TaskTemplate.where('task_template_title LIKE(?)', "%#{search}%")
    else
      TaskTemplate.all
    end
  end
end
