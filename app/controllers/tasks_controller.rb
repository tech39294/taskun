class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]

  def index
    # 期限が3日以内のサブタスクを持つタスクを取得
    emergent_tasks = Task.includes(:subtasks).select do |task|
      task.subtasks.any? { |subtask| subtask.subtask_deadline.present? && subtask.subtask_deadline <= 3.days.from_now }
    end

    # 重要なタスク（期限が3日以内のサブタスクを持つタスク以外）を取得
    important_tasks = Task.includes(:subtasks).where.not(id: emergent_tasks.map(&:id)).where(importance_status_id: 1).order(task_deadline: :asc)

    # 上記の条件を満たさないタスク（期限が3日以内のサブタスクを持つものも、重要なものも含まない）を取得
    other_tasks = Task.includes(:subtasks).where.not(id: emergent_tasks.map(&:id)).where.not(importance_status_id: 1).order(task_deadline: :asc)

    @tasks = emergent_tasks + important_tasks + other_tasks
  end

  def new
    @task = Task.new
    @task.subtasks.build
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_title, :task_deadline, :importance_status_id, :memo, :task_template_id,
                                 subtasks_attributes: [:subtask_title, :subtask_deadline]).merge(user_id: current_user.id)
  end
end
