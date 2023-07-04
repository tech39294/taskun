class Task < ApplicationRecord
  belongs_to :user
  belongs_to :task_template, optional: true
  has_many :subtasks
  accepts_nested_attributes_for :subtasks

  validates :task_title, presence: true
  validates :task_deadline, presence: true
  validates :importance_status_id, presence: true, numericality: { only_integer: true }, inclusion: { in: [1, 2] }

  validates_associated :subtasks

  def start_time
    task_deadline
  end

  def self.search(search)
    if search != ""
      Task.where('task_title LIKE(?) AND archived = ?', "%#{search}%", true)
    else
      Task.all
    end
  end
  

end
