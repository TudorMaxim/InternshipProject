Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  get '/friends', to: "friendships#index"

  resources :users
  resources :friendships
  resources :notifications
  resources :challenges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
