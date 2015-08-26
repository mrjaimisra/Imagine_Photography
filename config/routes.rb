Rails.application.routes.draw do
  root to: "site#index"

  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/profile", to: "users#show"
  patch "/profile", to: "users#update"
  get "/profile/edit", to: "users#edit"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  namespace "admin" do
    resources :items, except: [:show]
    resource :dashboard, only: [:show]
    resources :orders, only: [:index, :show, :update]
  end

  namespace :menu do
    resources :categories, only: [:show]
  end

  resources :photos, only: [:index, :show]

  get "/photographers", to: "users#photographers"

  get "/explore", to: "photos#index"
  # post "/menu", to: "location#check_zipcode", as: :zipcode
  # get "meals/:id", to: "items#show", as: :meal
  # get "menu/:id", to: "menu/categories#show"

  post "/cart_items", to: "cart_items#create"
  put "/cart_items", to: "cart_items#update"
  get "/cart", to: "cart_items#index"

  delete "/cart_items", to: "cart_items#destroy"

  resources :orders, only: [:create, :index, :show]
end


