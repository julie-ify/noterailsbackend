Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'
  resources :notes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :users, only: [:create]
  post "login", to: "users#login"
  get "auto_login", to: "users#auto_login"
end
