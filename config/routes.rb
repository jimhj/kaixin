class MobileConstraint
  def self.matches?(request)
    agent_str = request.user_agent.to_s.downcase
    (agent_str =~ Regexp.new(MOBILE_USER_AGENTS)) or request.subdomain == 'm' 
  end
end 

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  concern :sessionable do
    get :signup, to: 'users#new'
    post :signup, to: 'users#create'
    get :login, to: 'sessions#new'
    post :login, to: 'sessions#create'
    delete :logout, to: 'sessions#destroy'
    get :login_state, to: 'sessions#login_state'
  end

  # 移动站的页面
  constraints(MobileConstraint) do
    scope module: 'mobile', as: :mobile do
      root to: 'jokes#index'
      resources :jokes do
        collection do
          get :hot
          get :shenhuifu
          get :qutu
          get :duanzi
          get :random
        end        
      end

      concerns :sessionable
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
  resources :tags, only: [:index, :show]
  concerns :sessionable

  namespace :settings do
    resource :password, only: [:show, :update]
    resource :profile, only: [:show, :update]
  end
end
