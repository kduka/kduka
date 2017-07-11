Rails.application.routes.draw do
match '/', to: 'products#index', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]
  # get 'home/user'
# 
  # get 'home/store' 
#  get 'products/category/:id' => 'products#category'
    get '/products/category/(:id)', to: 'products#category', as: 'product_category'
   get 'carts/shipping' => 'carts#shipping'
   get 'carts/complete' => 'carts#complete'
   post 'carts/pay' => 'carts#pay'
   get 'carts/success', to: 'carts#success', as: 'cart_success'
   get '/order_items/clear' => 'order_items#clear'
   get '/products/manage/(:store_id)', to: 'products#manage', as: 'products_manage'
   get 'stores/orders/(:store_id)', to: 'stores#orders', as: 'store_orders'

  devise_for :stores, :controllers => { registrations: 'store_registrations' }
  devise_for :users, :controllers => { registrations: 'user_registrations', sessions: 'user_sessions' }
  
  resources :stores do
  #devise_for :stores
    resources :products
    resources :categories
    end
    
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  
  #match '/', to: 'stores#index', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]
   
#   
  #root to: "home#user"
  root to: "products#index"
end
