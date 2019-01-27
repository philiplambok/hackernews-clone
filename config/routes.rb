# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'

  resources :users

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
