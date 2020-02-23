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
    end
  end
  resources :events do
    member do
      get 'copy'
    end
  end
  resources :events_users, only: [:create, :destroy]
  resources :rooms, only: [:index, :show]
  resources :messages, only: [:create, :destroy]

  namespace :admin do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
