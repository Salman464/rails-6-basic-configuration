# frozen_string_literal: true

Rails.application.routes.draw do
  resources :approvals, only: %i[index show] do
    member do
      put 'approve'
      put 'reject'
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
    end
  end
end
