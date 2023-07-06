Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users, only: [:show, :edit, :update]

  patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'

  resources :tasks do
    resources :subtasks
    post :archive, on: :member
    get :archive_show, on: :member
    collection do
      get 'archive_index'
      get 'search'
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

