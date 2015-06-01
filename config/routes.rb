Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # 移动站的页面
  constraints subdomain: 'm' do
    scope module: 'mobile' do
      p 123123123123123
      get '/', to: 'jokes#index', as: :mobile_root
      resources :jokes
    end
  end
  
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

    collection do
      get :hot
      get :shenhuifu
      get :qutu
      get :duanzi
    end
  end

  resources :users
  resources :sessions
  resources :tags, only: [:index, :show]

  get :signup, to: 'users#new'
  post :signup, to: 'users#create'
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'
  get :login_state, to: 'sessions#login_state'

  namespace :settings do
    resource :password, only: [:show, :update]
    resource :profile, only: [:show, :update]
  end
end
