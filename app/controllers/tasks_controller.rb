class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :show, :edit]
  before_action :restrict_access, only: [:edit]
  before_action :set_task, only: [:show, :edit, :update]



  def index
    urgent_important_tasks = current_user.tasks.includes(:subtasks)
                                         .where(importance_status_id: 1, subtasks: { subtask_deadline: Date.today..(Date.today + 3.days) })
                                         .order(task_deadline: :asc)

    urgent_tasks = current_user.tasks.includes(:subtasks)
                               .where(importance_status_id: 2, subtasks: { subtask_deadline: Date.today..(Date.today + 3.days) })
                               .order(task_deadline: :asc)

    important_tasks = current_user.tasks.includes(:subtasks)
                                  .where(importance_status_id: 1, subtasks: { subtask_deadline: (Date.today + 4.days)..Float::INFINITY })
                                  .order(task_deadline: :asc)

    other_tasks = current_user.tasks.includes(:subtasks)
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

  def show
    return if @task.user_id == current_user.id
    redirect_to tasks_path
  end

  def edit
  end
  
  def update  
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def restrict_access
    @task = Task.find(params[:id])
    if current_user != @task.user
      redirect_to tasks_path
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
    @subtasks = @task.subtasks
  end

  def task_params
    params.require(:task).permit(:task_title, :task_deadline, :importance_status_id, :memo, :task_template_id,
                                 subtasks_attributes: [:id, :subtask_title, :subtask_deadline]).merge(user_id: current_user.id)
  end
end
