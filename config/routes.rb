Rails.application.routes.draw do
  root 'jokes#index'
  resources :jokes
  resources :users
  resources :sessions
  resources :tags

  get :signup, to: 'users#new'
  post :signup, to: 'users#create'
  get :login, to: 'sessions#new'
end
