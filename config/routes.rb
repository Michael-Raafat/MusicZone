Rails.application.routes.draw do
  get 'track_listener_controller/index'
  get 'users/home'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'users#home'
end
