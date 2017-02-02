require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1,
      constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :folders, only: [:create, :update, :destroy]
      end
      resources :sessions, only:  [:create, :destroy]
      resources :folders, only: [:show, :index]
    end
  end
end
