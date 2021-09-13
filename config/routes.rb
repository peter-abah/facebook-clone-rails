Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts do
    resources :comments, only: %i[new create]
    resources :likes, only: %i[create]
  end

  resources :comments, only: %i[edit update destroy]
  resources :likes, only: %i[destroy]

  get '/search', to: 'search#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
