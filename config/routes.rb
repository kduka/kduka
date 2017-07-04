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
   get '/order_items/clear' => 'order_items#clear'
   get '/products/manage/(:store_id)', to: 'products#manage', as: 'products_manage'

  devise_for :stores, :controllers => { registrations: 'store_registrations' }
  devise_for :users, :controllers => { registrations: 'user_registrations', sessions: 'user_sessions' }
  
  resources :stores do
  #devise_for :stores
    resources :products
    resources :categories
    end
    
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  
  #match '/', to: 'blogs#index', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]
   
#   
  #root to: "home#user"
  root to: "products#index"
end
