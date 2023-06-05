class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new]

  def index
    urgent_important_tasks = Task.includes(:subtasks)
                                 .where(importance_status_id: 1, subtasks: { subtask_deadline: Date.today..(Date.today + 3.days) })
                                 .order(task_deadline: :asc)
  
    urgent_tasks = Task.includes(:subtasks)
                       .where(importance_status_id: 2, subtasks: { subtask_deadline: Date.today..(Date.today + 3.days) })
                       .order(task_deadline: :asc)
  
    important_tasks = Task.includes(:subtasks)
                          .where(importance_status_id: 1, subtasks: { subtask_deadline: (Date.today + 4.days)..Float::INFINITY })
                          .order(task_deadline: :asc)
  
    other_tasks = Task.includes(:subtasks)
                      .where(importance_status_id: 2, subtasks: { subtask_deadline: (Date.today + 4.days)..Float::INFINITY })
                      .order(task_deadline: :asc)
  
    @tasks = urgent_important_tasks + urgent_tasks + important_tasks + other_tasks
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
