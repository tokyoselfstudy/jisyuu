Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }

  root 'top#index'
  get 'menu', to: 'top#menu'
  get 'manager_menu/:event_id', to: 'top#manager_menu'
  resources :users, only: [:show] do
    member do
      get 'events'
      get 'copy_events'
      get 'my_records'
    end
  end
  resources :events do
    member do
      post 'copy'
    end
  end
  resources :events_users, only: [:create, :destroy]
  resources :rooms, only: [:index, :show]
  resources :messages, only: [:create, :destroy]
  resources :learn_records do
    member do 
      get 'menu'
    end
  end
  resources :blogs

  namespace :api do
    resources :messages, only: :index, defaults: { format: 'json' } do
      get :read_count, on: :collection
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :update] do
      resources :events_users, only: [:destroy]
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
