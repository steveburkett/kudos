Rails.application.routes.draw do
  root to: 'kudos#index'
  resources :kudos
end
