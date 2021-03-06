Rails.application.routes.draw do
  root to: "site#index"

  get "/sign_up", to: "users#new"
  post "/sign_up", to: "users#create"
  get "/profile", to: "users#show", as: :profile
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

  namespace :photos do
    resources :categories, param: :name, only: [:show]
  end

  get "/explore", to: "photos#index"
  resources :photos, only: [:show]

  get "/cart", to: "cart_photos#index"

  resources :cart_photos, only: [:create, :update, :destroy]
  resources :orders, only: [:create, :index, :show]
  resources :stores, only: [:index, :new, :create],
                     path: :photographers, as: :photographers

  get "/:photographer/edit", to: "stores#edit", as: "edit_photographer"
  get "/:photographer", to: "stores/photos#index", as: "photographer"
  patch "/:photographer", to: "stores#update"
  put "/:photographer", to: "stores#update"

  namespace :stores, path: ":photographer", as: :photographer do
    resources :photos, only: [:index, :show, :new, :create,
                              :edit, :update, :destroy]
    resources :orders, only: [:index, :show]
    resources :categories, param: :name, only: [:show]
  end
end
