Rails.application.routes.draw do
  root to: "site#index"

  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/profile", to: "users#show"


  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace "admin" do
    resources :items, only: [:new, :create, :edit, :destroy]
    resource :dashboard, only: [:show]
    resources :orders, only: [:index]
  end

  namespace :menu do
    resources :categories, only: [:show]
  end

  get "/menu", to: "items#index", as: :menu
  post "/menu", to: "location#check_zipcode", as: :zipcode
  get "meals/:id", to: "items#show", as: :meal


  get "menu/:id", to: "menu/categories#show"

  post "/cart_items", to: "cart_items#create"
  put "/cart_items", to: "cart_items#update"
  get "/cart", to: "cart_items#index"

  delete "/cart_items", to: "cart_items#destroy"

  post "/orders", to: "orders#create"

  get "/orders", to: "orders#index"
  get "/orders/:id", to: "orders#show"
end


