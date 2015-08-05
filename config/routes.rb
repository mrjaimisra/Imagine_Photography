Rails.application.routes.draw do
  root to: "site#index"

  get "/menu", to: "items#index", as: :menu

  namespace :menu do
    resources :categories, only: [:show]
  end

  get "meals/:id", to: "items#show", as: :meal

  get "/cart", to: "cart_items#index"
  post "/cart_items", to: "cart_items#create"
end
