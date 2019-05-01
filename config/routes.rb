Rails.application.routes.draw do
  resources :tags, only: [:index, :create, :show]
  resources :tracks, only: [:index]

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'tracks#index'
end
