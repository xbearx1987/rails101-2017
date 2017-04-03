Rails.application.routes.draw do
  devise_for :users
  resources :groups do
    member do
      post :join
      post :quit
    end

    resources :posts
  end

  resources :movies do
    member do
      post :add_favorite
      post :remove_favorite
    end

    resources :reviews
  end

  namespace :account do
    resources :groups
    resources :posts

    resources :movies
    resources :reviews
  end

  root 'movies#index'
end
