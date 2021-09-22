Rails.application.routes.draw do
  root 'posts#index'

  get '/search', to: 'search#search'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  resources :posts do
    resources :comments, only: %i[new create]
    resources :likes, only: %i[create]
  end

  resources :comments, only: %i[edit update destroy]
  resources :likes, only: %i[destroy]

  resources :users, only: %i[show edit update]
  get '/friends', to: 'users#friends'
  
  resources :friend_requests, only: %i[index] 
  get '/friend_requests/accept/:id', to: 'friend_requests#accept_request'
  get '/friend_requests/delete/:id', to: 'friend_requests#delete_request'
  get '/friend_requests/send/:id', to: 'friend_requests#send_request'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
