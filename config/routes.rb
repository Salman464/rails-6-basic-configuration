Rails.application.routes.draw do
  get 'users/profile/:id', to: "users#profile"
  Rails.application.routes.draw do
    devise_for :users, controllers: {
      sessions: 'users/sessions'
    }
  end

end
