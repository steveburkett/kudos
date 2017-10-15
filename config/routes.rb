Rails.application.routes.draw do
  devise_for :users
  root to: 'kudos#index'
  resources :kudos

  authenticated do
    root to: "kudos#index", as: :authenticated_root
  end
end
