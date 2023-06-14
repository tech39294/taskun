class SubtaskTemplatesController < ApplicationController
  def new
    @subtask_template = @task_template.subtask_templates.build
  end

  def create
    @subtask_template = @task_template.subtask_templates.build(subtask_template_params)
    if @subtask_template.save
      redirect_to [@task_template, @subtask_template]
    else
      render 'new'
    end
  end

  private

  def subtask_template_params
    params.require(:subtask_template).permit(:subtask_template_title, :subtask_template_days)
  end
end
