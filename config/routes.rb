Rails.application.routes.draw do
  root "books#index"

  get "books/show", to: "books#show"
  get "books/find", to: "books#find"
  get "books/search", to: "books#search"
  get "books/searchlike", to: "books#searchlike"
  get "sessions/new"
  get "users/new"
  resources :activities
  resources :books do
    resources :reviews do
      resources :comments
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :users do
    member do
      get :following, :followers
    end
  end
  post "/like", to: "likes#create"
  delete "/unlike", to: "likes#destroy"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :suggests

  namespace :admin do
    mount Ckeditor::Engine => '/ckeditor'
    root "static_pages#index"
    resources :books, except: :show
    resources :categories, except: [:edit, :show]
    resources :users
    resources :suggests
  end
end
