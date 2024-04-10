require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'subscribe', to: 'subscriptions#subscribe'
      delete 'unsubscribe', to: 'subscriptions#unsubscribe'
      get 'confirm', to: 'subscriptions#confirm'
      resources :weathers, only: [:index, :create, :update, :destroy] do
        collection do
          get 'forecast' # Adds a custom route for /api/v1/weathers/forecast
        end
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Mount Sidekiq web interface for monitoring
  mount Sidekiq::Web => '/sidekiq'

  # Defines the root path route ("/")
  # root "posts#index"
end
