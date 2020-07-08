Rails.application.routes.draw do
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products, only: [:index, :new, :create, :show] do
    resources :orders, only: [:new] do
      collection do
        get :create
      end # 一時的にcreateをcollectionでビュー確認しています。
    end
  end
  resources :users, only: [:new, :edit, :update, :show, :create] do
    collection do 
      get :logout
    end
  end
  resources :creditcards, only: [:show, :new]
end
