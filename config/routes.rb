Rails.application.routes.draw do
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "users#index"
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
  end

      namespace :api, defaults: { format: :json } do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
    end
end