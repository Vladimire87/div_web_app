Rails.application.routes.draw do
  resources :holdings
  resources :portfolios
  devise_for :users
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
