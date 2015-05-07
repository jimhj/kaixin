Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root 'jokes#index'

  concern :votable do
    post :up_vote
    post :down_vote
  end

  resources :jokes do
    concerns :votable
    resources :comments, shallow: true do 
      concerns :votable
    end
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
