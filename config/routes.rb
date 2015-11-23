require 'sidekiq/web'

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :vacancies do
    get 'page/:page', :action => :index, :on => :collection
    put 'approve', :on => :member
  end

  resources :pages, :only => :show
  root :to => 'vacancies#index'
  resources :entries, :only => [:show, :index]

  mount Sidekiq::Web, at: '/sidekiq'
end
