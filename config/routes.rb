Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/order", to: "static_pages#order"
    get "/detail", to: "static_pages#detail"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    get "pages/search", to: "pages#search", as: "search_page"
    resources :account_activations, only: :edit
    resources :users
    resources :password_resets, only: %i(new create edit update)

    namespace :admin do
      resources :soccer_fields, except: %i(show)
      get "/soccer_field_path/:id", to: "soccer_fields#destroy"
    end
  end
end
