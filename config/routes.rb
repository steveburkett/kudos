Rails.application.routes.draw do
  devise_for :users
  root to: 'kudos#index'
  resources :kudos
end
