Rails.application.routes.draw do
  root 'jokes#index'
  resources :jokes
end
