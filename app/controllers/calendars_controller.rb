class CalendarsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @tasks = current_user.tasks.where(archived: false)
  end
end
