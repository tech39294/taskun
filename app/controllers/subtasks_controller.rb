class SubtasksController < ApplicationController
  def new
    @subtask = @task.subtasks.build
  end

  def create
    @subtask = @task.subtasks.build(subtask_params)
    if @subtask.save
      redirect_to [@task, @subtask]
    else
      render 'new'
    end
  end

  private

  def subtask_params
    params.require(:subtask).permit(:subtask_title, :subtask_deadline)
  end
end
