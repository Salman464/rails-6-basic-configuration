Rails.application.routes.draw do
  
  resources :users do
    member do
      get 'send_verification_token'
    end
  end 

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
