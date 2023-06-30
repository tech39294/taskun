Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users, only: [:show, :edit, :update]

  resources :tasks do
    resources :subtasks
    post :archive, on: :member
    collection do
      get 'archive_index'
    end
  end

  resources :task_templates do
    resources :tasks, only: [:new, :create], controller: 'task_templates/tasks'
    resources :subtask_templates
    collection do
      get 'search'
    end
  end

  resources :calendars, only: [:index]

end

