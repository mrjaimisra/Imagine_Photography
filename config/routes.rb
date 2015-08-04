Rails.application.routes.draw do
  root to: "site#index"

  resources :items, only: [:index, :show]
  get "/menu/:category", to: "categories#index", as: :category
end
