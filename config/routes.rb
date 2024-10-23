Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :wallets do
    collection do
      get 'user', to: 'wallets#user_wallet'
      get 'teams/:team_id', to: 'wallets#team_wallet'
      get 'stocks/:stock_id', to: 'wallets#stock_wallet'
      post :deposit
      post :withdraw
      post :transfer
    end
  end

  resources :transactions, only: [ :index ]
end
