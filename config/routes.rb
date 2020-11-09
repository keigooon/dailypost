Rails.application.routes.draw do
  root to: "posts#index"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "signup", to: "users#new"
  resources :users, only: [:show, :create] do
    member do
      get :followings
      get :followers
      get :like_posts
    end
  end
    
  resources :posts
  resources :likes, only: [:create, :destroy]
  
  resources :relationships, only: [:create, :destroy]
end
