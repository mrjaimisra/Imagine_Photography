Rails.application.routes.draw do
  root to: "site#index"

  resources :items, only: [:show]
  get "/menu", to: "items#index", as: :menu
  get "/menu/:category", to: "categories#show", as: :category
end
