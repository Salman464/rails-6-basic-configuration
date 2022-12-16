Rails.application.routes.draw do
  get 'users/profile/:id', to: "users#complete_profile"

  resources :users, only: [:update]

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
