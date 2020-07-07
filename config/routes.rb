Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:index, :new, :create] 
  resources :users, only: [:new, :edit, :update, :show, :create]
end
