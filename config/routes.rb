Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
<<<<<<< HEAD
  devise_for :users
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
  get '/friends', to: "friendships#index"
  get '/leaderboard', to: "leaderboards#index"
  get "/inventory", to: "bought_skins#index"
  get 'charges/create'

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
  resources :bought_skins, only: [:create]

  resources :conversations do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  mount ActionCable.server => '/cable'

=======
>>>>>>> 507e1839bd0bd2bd5110eb622a62489feade8e2f
end
