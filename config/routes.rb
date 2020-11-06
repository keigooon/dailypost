Rails.application.routes.draw do
  root to: "posts#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:show, :create]
  
  resources :posts
end
