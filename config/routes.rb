Rails.application.routes.draw do
  post "/signup", to: "users#create"
  get "/me", to: "users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"


  # nested resource routing since we want the user to be logged in to do more


  resources :users, only: [:show] do
    resources :reviews, only: [:index, :create, :update, :destroy]
  end

  resources :users, only: [:show] do
    resources :favourite_games, only: [:index, :create, :destroy]
  end
  # admin user routing

  resources :games, only: [:show, :index, :create, :update, :destroy]

  resources :games, only: [:show] do
    resources :reviews, only: [:index, :create]
  end

  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
