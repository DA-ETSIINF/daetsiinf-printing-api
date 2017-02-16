require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1,
      constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :folders, only: [:create, :update, :destroy, :show]
      resources :documents, only: [:create, :update, :destroy, :show]
      resources :sessions, only: [:create, :destroy]
      resources :transactions, only: [:create]
      resources :jobs, only: [:create]
    end
  end
end
