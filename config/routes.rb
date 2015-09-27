Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :vacancies do
    get 'page/:page', :action => :index, :on => :collection
    put 'approve', :on => :member
  end
  resources :pages, :only => :show
  root :to => 'vacancies#index'
end
