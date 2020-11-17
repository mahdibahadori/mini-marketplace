Rails.application.routes.draw do    
  resources :items
  resources :payments, only: [:create,]
  devise_for :users
  root to: 'items#index'
  
end
