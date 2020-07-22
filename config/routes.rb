Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :products do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_toppage_children', defaults: { format: 'json' }
      get 'get_toppage_grandchildren', defaults: { format: 'json' }
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'show_sold'
    end
    resource :orders do
      member do
        get  "buy"
        post "pay"
      end
    end
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:show]
  resources :orders, only: [:new, :create]
  resources :users, only: [:new, :edit, :show] do
    member do
      get 'user_products'
    end
  end
  resources :card, only: [:new, :create, :show, :destroy] do
  end
end
