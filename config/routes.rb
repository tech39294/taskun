Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :tasks do
    resources :subtasks
  end

  resources :task_templates do
    resources :tasks, only: [:new, :create], controller: 'task_templates/tasks'
    resources :subtask_templates
    collection do
      get 'search'
    end
  end

end

