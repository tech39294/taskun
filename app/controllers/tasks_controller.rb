class TasksController < ApplicationController
  def index
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task
    else
      render 'new'
    end
  end

  private

  def task_params
    params.require(:task).permit(:task_title, :task_deadline, :importance_status_id, :memo, :user_id, :task_template_id, subtasks_attributes: [:id, :subtask_title, :subtask_deadline])
  end

end
