require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {registrations: "web/users/registrations"}
  mount Sidekiq::Web => '/sidekiq'

  devise_scope :user do
    get 'sign_out', to: 'devise/sessions#destroy', as: :logout
  end

  namespace :admin do
    get '/mentors', to: 'mentors#index', as: :mentors
    get '/mentees', to: 'mentees#index', as: :mentees
  end

  namespace :v1, defaults: { format: :json } do
    resources :users,           only: [:update, :show]
    resources :authentications, only: [:create]
  end

  scope module: :web do
    resources :users,           only: [:update, :show]
    get   '/profile/edit',    to: 'profiles#edit', as: :edit_profile
    get   '/profile',    to: 'profiles#show', as: :profile
    patch '/profile',   to: 'profiles#update'

    resources :mentor_profiles,     only: [:update, :edit]
    resources :mentee_profiles,     only: [:update, :edit]
    get   '/preferences', to: 'preferences#show', as: :preferences


    resources :home,            only: [:index]
  end
  # You can have the root of your site routed with "root"
  root 'welcome#index'
end
