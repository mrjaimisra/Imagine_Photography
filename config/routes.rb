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

  get "/explore", to: "photos#index"
  resources :photos, only: [:show]

  # post "/menu", to: "location#check_zipcode", as: :zipcode
  # get "meals/:id", to: "photos#show", as: :meal
  # get "menu/:id", to: "menu/categories#show"

  # post "/cart_photos", to: "cart_photos#create"
  # put "/cart_photos", to: "cart_photos#update"
  # delete "/cart_photos", to: "cart_photos#destroy"

  get "/cart", to: "cart_photos#index"

  resources :cart_photos, only: [:create, :update, :destroy]

  resources :orders, only: [:create, :index, :show]

  resources :stores, only: [:index, :show], path: :photographers, as: :photographers

  namespace :stores, path: ":photographer", as: :photographer do
    resources :photos, only: [:index, :show]
  end
end
