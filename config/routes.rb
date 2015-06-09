class MobileConstraint
  def self.matches?(request)
    agent_str = request.user_agent.to_s.downcase
    (agent_str =~ Regexp.new(MOBILE_USER_AGENTS)) or request.subdomain == 'm' 
  end
end 

# class AdminConstraint
#   def self.matches?(request)
#     if request.session[:user_id]
#       user = User.find request.session[:user_id]
#       user && user.admin?
#     end
#   end
# end

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

  concern :votable do
    post :up_vote
    post :down_vote
  end  

  concern :jokeable do
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
        get :random
        get :search
      end
    end    
  end

  # 移动站的页面
  constraints(MobileConstraint) do
    scope module: 'mobile', as: :mobile do
      root to: 'jokes#index'
      concerns :jokeable
      concerns :sessionable
    end
  end
  
  # 桌面站
  root 'jokes#index'
  concerns :jokeable
  resources :users
  resources :tags, only: [:index, :show]
  concerns :sessionable

  namespace :settings do
    resource :password, only: [:show, :update]
    resource :profile, only: [:show, :update]
  end

  # 管理后台
  namespace :admin do
    root to: 'jokes#index'
    resources :jokes do
      collection do
        get :hot
        get :shenhuifu
        get :qutu
        get :duanzi
      end

      member do
        post :approve
        post :reject
        post :recommend
        post :unrecommend
      end
    end      
    
    resources :tags    
    resources :users
    resources :comments
    resources :websites
    resources :ads
  end
end
