Rails.application.routes.draw do    
  resources :items
  resources :payments, only: [:create,]
  devise_for :users
  get "/payments/success", to: "payments#success"
  get "/payments/cancel", to: "payments#cancel"
  post "/payments/webhook", to: "payments#webhook"
  root to: 'items#index'
  
end
