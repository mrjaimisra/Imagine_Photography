Rails.application.routes.draw do
  root to: "site#index"

  resources :items, only: [:index, :show]
end
