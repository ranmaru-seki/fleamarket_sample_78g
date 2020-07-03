Rails.application.routes.draw do
  root 'items#index'
  # root 'users#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :new] 
  resources :users, only: [:new, :edit, :update, :show, :create]
end
