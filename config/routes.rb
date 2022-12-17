Rails.application.routes.draw do
  
  resources :users do
    member do
      get 'send_verification_token'
      get 'send_number_verification_token'
      post 'verify_token'
      post 'verify_number_token'
      get 'verification'
    end
  end 

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
