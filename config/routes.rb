require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Sidekiq::Web => '/sidekiq'

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', as: :logout
  end

  namespace :v1, defaults: { format: :json } do
    resources :users,           only: [:update, :show]
    resources :authentications, only: [:create]
  end

  scope module: :web do
    resources :users,           only: [:update]
    get '/profile', to: 'users#edit', as: :profile
    resources :home,            only: [:index]
  end
  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
