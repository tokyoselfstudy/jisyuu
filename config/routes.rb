Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
  }

  root 'top#index'
  resources :users, only: [:show]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
