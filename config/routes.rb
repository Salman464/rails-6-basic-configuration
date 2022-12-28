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
      get 'send_email_verification'
      get 'send_phone_verification'
      post 'verify_email_token'
      post 'verify_phone_token'
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
