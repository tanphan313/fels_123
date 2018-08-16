Rails.application.routes.draw do
  root "static_pages#home"

  get "signup" => "users#new"
  post "signup" => "users#create"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :users
  resources :passwords, only: [:edit, :update]
  resources :relationships, only: [:create, :destroy]
  resources :categories, only: [:show, :index] do
    resources :lessons, only: [:create, :show, :update]
  end
  resources :words, only: [:index]

  namespace :admin do
    root "admins#home"

    resources :categories
    resources :words, except: [:index, :new, :show]
    resources :users, except: [:show]
  end
end
