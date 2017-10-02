Rails.application.routes.draw do

  match '/', to: 'products#index', constraints: {subdomain: /.+/}, via: [:get, :post, :put, :patch, :delete]
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
  get 'store/account' => 'stores#account'
  get 'users/home' => 'users#home'
  get 'users/stores' => 'users#stores'
  get 'admins/ndeto' => 'admins/ndeto'
  get 'stores/social' => 'stores#social'
  get 'products/view/(:sku)' => 'products#view', as: 'product_view'
  get 'stores/theme' => 'stores#layouts'
  put 'stores/update_social'
  put 'stores/update_store'
  put 'stores/update_layout'
  get 'stores/deliver' => 'stores#deliver'
  put 'stores/update_delivery'
  get '/home' => 'products#home'
  get '/about' => 'products#about'
  get '/contact' => 'products#contact'
  get 'stores/pages' => 'stores#pages'
  put 'stores/update_pages'
  get '/all' => 'products#all'
  post '/stores/contact' => 'stores#contact'
  devise_for :stores, :controllers => {registrations: 'store_registrations', sessions: 'store_sessions'}
  devise_for :users, :controllers => {registrations: 'user_registrations', sessions: 'user_sessions'}

  resources :stores do
    resources :products
  end

  resources :categories do
    resources :sub_categories
  end
  resources :users
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :store_campaigns

  #match '/', to: 'stores#index', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]

  #
  root to: "stores#index"
  #root to: "products#index"
end
