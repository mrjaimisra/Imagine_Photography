Rails.application.routes.draw do
  root to: "site#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"

  # namespace :menu do
    get "menu/:id", to: "menu/categories#show"
  # end

  # resources :users, only: [:index]

  get "/menu", to: "items#index", as: :menu

  get "meals/:id", to: "items#show", as: :meal

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
end
