Rails.application.routes.draw do

  resources :categories
  get 'home/user'

  get 'home/store'

  get 'carts/shipping' => 'carts#shipping'
  post 'carts/pay' => 'carts#pay'
  get '/order_items/clear' => 'order_items#clear'

  devise_for :stores, :controllers => { registrations: 'store_registrations' }
  devise_for :users, :controllers => { registrations: 'user_registrations', sessions: 'user_sessions' }
  resources :stores do
  #devise_for :stores
    resources :products, only: [:index, :create, :new]
    end
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  root to: "home#user"

end
