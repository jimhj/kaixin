Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'jokes#index'

  resources :jokes do
    resources :comments, only: [:create, :destroy, :index]
  end

  resources :users
  resources :sessions
  resources :tags

  get :signup, to: 'users#new'
  post :signup, to: 'users#create'
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'
end
