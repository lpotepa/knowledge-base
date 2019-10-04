# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'
  resources :articles

  namespace :api, default: { format: :json } do
    namespace :v1 do
      resources :articles
    end
  end
end
