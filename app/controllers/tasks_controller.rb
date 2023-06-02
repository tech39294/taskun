class TasksController < ApplicationController
  def index
  end

  def new
    @task = Task.new
    @task.subtasks.build
  end
  
  def create
  end
  
end
