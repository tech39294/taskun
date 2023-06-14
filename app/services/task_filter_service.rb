class TaskFilterService
  def initialize(user_id)
    @user_id = user_id
  end

  def filtered_tasks
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

    urgent_important_tasks + urgent_tasks + important_tasks + other_tasks
  end
end
