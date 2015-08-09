Rails.application.routes.draw do
  root to: "site#index"

  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace :menu do
    resources :categories, only: [:show]
  end

  get "/menu", to: "items#index", as: :menu
  get "meals/:id", to: "items#show", as: :meal
  get "menu/:id", to: "menu/categories#show"

  post "/cart_items", to: "cart_items#create"
  put "/cart_items", to: "cart_items#update"
  get "/cart", to: "cart_items#index"

  delete "/cart_items", to: "cart_items#destroy"

  get "/orders", to: "orders#index"
  post "/orders", to: "orders#create"
end
