module TaskTemplates
  class TasksController < ApplicationController
    before_action :authenticate_user!, only: [:new]

    def new
      @task_template = TaskTemplate.find(params[:task_template_id])
      @task = @task_template.tasks.build(task_title: @task_template.task_template_title)
      @task.subtasks.build(subtask_title: @task_template.subtask_templates.pluck(:subtask_template_title))
      render :new
    end

    def create
      @task_template = TaskTemplate.find(params[:task_template_id])
      @task = @task_template.tasks.build(task_params)
    
      if @task.save
        redirect_to @task, notice: 'タスクが作成されました。'
      else
        render :new
      end
    end
    
    private

    def task_params
      params.require(:task).permit(:task_title, :task_deadline, :importance_status_id, :memo, :task_template_id,
                                   subtasks_attributes: [:id, :subtask_title, :subtask_deadline]).merge(user_id: current_user.id, task_template_id: params[:task_template_id])
    end
    
    
  end
end
