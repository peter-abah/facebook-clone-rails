Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users
  resources :users, only: %i[show edit]
  get '/friends', to: 'users#friends'

  resources :posts do
    resources :comments, only: %i[new create]
    resources :likes, only: %i[create]
  end

  resources :comments, only: %i[edit update destroy]
  resources :likes, only: %i[destroy]

  get '/search', to: 'search#search'
  
  get '/friend_requests/accept/:id', to: 'friend_requests#accept_request'
  get '/friend_requests/delete/:id', to: 'friend_requests#delete_request'
  get '/friend_requests/send/:id', to: 'friend_requests#send_request'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
