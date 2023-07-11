Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :url_mappers

  root "home#index"

  post   "/login",       to: "sessions#create"
  get    "/signup",   to: "users#new"
  post   "/signup",   to: "users#create"
  get    "/dashboard", to: "users#dashboard"
  delete "/logout", to: "sessions#destroy"
  get    "/:slug", to: "home#redirect_actual_url"
end
