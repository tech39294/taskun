class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :show, :edit, :destroy]
  before_action :restrict_access, only: [:edit, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy, :archive]

  def index
    task_filter_service = TaskFilterService.new(current_user.id)
    @tasks = task_filter_service.filtered_tasks
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
      if params[:archived] == "更新"
        redirect_to archive_index_tasks_path
      else
        redirect_to task_path(@task)
      end      
    else
      render :edit
    end
  end

  def destroy
    @subtasks.destroy_all
    @task.destroy

    if params[:param] == 'archive'
      redirect_to archive_index_tasks_path
    else
      redirect_to tasks_path
    end
    
  end

  def archive
    @task.update(archived: true)
    redirect_to tasks_path
  end

  def archive_index
    @archived_tasks = current_user.tasks.where(archived: true).order(task_deadline: :desc)
  end

  private

  def set_task
    @task = Task.find(params[:id])
    @subtasks = @task.subtasks
  end

  def restrict_access
    @task = Task.find(params[:id])
    return unless current_user != @task.user

    redirect_to tasks_path
  end

  def task_params
    params.require(:task).permit(:task_title, :task_deadline, :importance_status_id, :memo, :task_template_id,
                                 subtasks_attributes: [:id, :subtask_title, :subtask_deadline]).merge(user_id: current_user.id)
  end
end
