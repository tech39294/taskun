class TaskTemplatesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :search]

  def new
    @task_template = TaskTemplate.new
    @task_template.subtask_templates.build
  end

  def create
    @task_template = TaskTemplate.new(task_template_params)
    if @task_template.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def search
    @task_templates = TaskTemplate.search(params[:keyword])
    render :index
  end

  private

  def task_template_params
    params.require(:task_template).permit(:task_template_title, :task_template_days,
                                          subtask_templates_attributes: [:id, :subtask_template_title, :subtask_template_days, :_destroy]).merge(user_id: current_user.id)
  end
end
