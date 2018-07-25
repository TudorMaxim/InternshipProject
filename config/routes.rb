Rails.application.routes.draw do
  get 'notifications/index'
  get 'notification/index'
  devise_for :users
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'

  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  get '/friends', to: "friendships#index"

  resources :users
  resources :friendships
  resources :notifications
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
