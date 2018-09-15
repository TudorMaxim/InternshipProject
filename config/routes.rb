Rails.application.routes.draw do

  get 'charges/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  get '/friends', to: "friendships#index"
  get '/leaderboard', to: "leaderboards#index"

  resources :users
  resources :friendships
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  resources :challenges
  resources :skins
  resources :charges
  resources :conversations do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  mount ActionCable.server => '/cable'

end
