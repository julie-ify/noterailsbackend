# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'
  resource :users, only: [:create]
  post 'login', to: 'users#login'
  get 'auto_login', to: 'users#auto_login'

  resources :notes
  get 'all-notes', to: 'notes#get_all_notes'
end
