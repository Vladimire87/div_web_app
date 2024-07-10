# frozen_string_literal: true

Rails.application.routes.draw do
  resources :portfolios do
    resources :holdings, only: [:new, :create]
  end
  devise_for :users
  root 'home#index'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
