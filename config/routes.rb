Rails.application.routes.draw do
  devise_for :users
  resources :carts do
    member do
      post :delete_all_items
      post :delete_item
      post :add_quantity
      post :reduce_quantity
    end
    collection do
      post :checkout
    end
  end
  resources :products, only: [:show] do
    member do
      post :add_to_cart
    end

  end
  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
    end
  end
  namespace :admin do
    resources :products
    resources :orders
  end
  namespace :account do
    resources :orders, only: [:index, :show]
  end
  get "welcome/index"
  root  "welcome#index"
end
