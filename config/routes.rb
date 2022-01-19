Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :user_sessions do
        collection do
          post :sign_in
        end
      end
      resources :products ,only: [:index]
      resources :scrapers
    end
  end
  apipie
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
