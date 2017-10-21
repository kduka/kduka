Rails.application.routes.draw do
  get 'store_deliveries/create'

  get 'store_deliveries/new'

  get 'ipn/index'

  match '/', to: 'home#index', constraints: { domain: 'co.ke', subdomain:'www.kduka' }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'products#index', constraints: {subdomain: /.+/}, via: [:get, :post, :put, :patch, :delete]

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
  get '/admins' => 'admins#index'
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
  get '/carts/auto' => 'carts#auto'
  get '/carts/manual' => 'carts#manual'
  get '/carts/collection' => 'carts#collection'
  post '/carts/location' => 'carts#location'
  get '/coupons/generate' => 'coupons#generate'
  get '/categories/feature/(:id)' => 'categories#feature', as: 'category_feature'
  get '/categories/unfeature/(:id)' => 'categories#unfeature', as: 'category_unfeature'
  post '/coupons/create_coupons' => 'coupons#create_coupons'
  get '/stores/active' => 'stores#active'
  post '/stores/activate' => 'stores#activate'
  post '/stores/deactivate' => 'stores#deactivate'
  get '/admins/layouts' => 'admins#layouts'
  get '/admins/ndeto' => 'admins#ndeto'
  post 'users/remote_santize' => 'users/remote_santize'
  post 'users/checkmail' => 'users/checkmail'
  post '/ipn' => 'ipn#index'
  post '/carts/update_shipping' => 'carts#update_shipping'
  get '/carts/checkout' => 'carts#checkout'
  get '/carts/trigger' => 'carts#trigger'
  post '/carts/red' => 'carts#red'


  devise_for :stores, :controllers => {registrations: 'store_registrations', sessions: 'store_sessions'}
  devise_for :users, :controllers => {registrations: 'user_registrations', sessions: 'user_sessions', confirmations:'user_confirmations',passwords:'user_passwords'}
  devise_for :admins, :controllers => {registrations: 'admins_registrations', sessions: 'admins_sessions'}

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
  resources :coupons
  resources :layouts
  resources :home
  resources :store_deliveries

  root to: "home#index"
  get '*path' => redirect('/')
end
