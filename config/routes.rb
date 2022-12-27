Rails.application.routes.draw do
  
  devise_scope :user do
    root to: 'devise/sessions#new'
  end

  resources :approvals, only: %i[index show] do
    member do
      put 'approve'
      put 'reject' 
    end
    collection do
      get 'filter'
    end
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :users do
    member do
      get 'send_verification_token'
      get 'send_number_verification_token'
      post 'verify_token'
      post 'verify_number_token'
      get 'verification'
      get 'completed'
      get 'create_session'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index new create]
    end
  end
end
