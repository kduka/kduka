Rails.application.routes.draw do
  get 'store_deliveries/create'
  get 'store_deliveries/new'
  get 'ipn/index'


  #match '/', to: 'products#index', constraints: {subdomain: /.+/}, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'home#index', constraints: { domain: 'co.ke', subdomain:'www.kduka' }, via: [:get, :post, :put, :patch, :delete]
  #match '/', to: 'products#full_site', constraints: { domain: 'm-jiadvertize.com', subdomain:'www' }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'products#index', constraints: {subdomain: /.+/}, via: [:get, :post, :put, :patch, :delete]


  get '/products/category/(:id)', to: 'products#category', as: 'product_category'
  get 'carts/shipping' => 'carts#shipping'
  get 'carts/complete' => 'carts#complete'
  post 'carts/pay' => 'carts#pay'
  get 'carts/success', to: 'carts#success', as: 'cart_success'
  get '/order/clear' => 'order_items#clear', as: 'order_items_clear'
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
  post 'users/checkmail_user' => 'users/checkmail_user'
  post '/ipn' => 'ipn#index'
  post '/carts/update_shipping' => 'carts#update_shipping'
  get '/carts/checkout' => 'carts#checkout'
  get '/carts/trigger' => 'carts#trigger'
  post '/carts/red' => 'carts#red'
  post '/ipn/b2c' => 'ipn#b2c'
  get '/admins/init' => 'admins#init'
  get 'stores/funds' => 'stores/funds'
  get 'carts/pay' => 'carts#pay'
  post 'carts/confirm' => 'carts#confirm'
  post 'stores/b2c' => 'stores/b2c'
  post 'stores/b2b' => 'stores/b2b'
  post 'stores/eft' => 'stores/eft'
  post '/home/web_mail' => 'home#web_mail'
  post  '/products/sort' => 'products#sort'
  post  '/products/search' => 'products#search'
  get  '/home/404' => 'home#not_found'
  get  '/home/error' => 'home#error'
  get '/help' => redirect('http://kduka.co.ke/help')
  get '/order/(:ref)' => 'stores#order', as: 'store_order'
  post '/stores/sendy' => 'stores#sendy'
  post '/stores/save_sendy' => 'stores#save_sendy'
  post '/stores/complete_order' => 'stores#complete_order'
  post '/stores/update_order' => 'stores#update_order'
  post '/stores/close_order' => 'stores#close_order'
  post '/stores/update_order' => 'stores#update_order'
  post '/stores/update_order2' => 'stores#update_order2'
  get '/stores/transactions' => 'stores#transactions'
  get 'admins/confirm_without_store' => 'admins#confirm_without_store'
  get 'admins/store_not_active' => 'admins#store_not_active'
  get 'products/allproducts' => 'products#allproducts'
  get 'stores/myorders' => 'stores#myorders'
  post '/carts/sendy_call'
  delete '/store/delete/:id' => 'admins#store_delete', as: 'store_delete'
  post '/stores/sendy_call'
  get 'admins/view/(:id)' => 'admins#view', as: 'admin_view'
  post 'store_registrations/update_password' => 'store_registrations#update_password'



  devise_for :stores, :controllers => {registrations: 'store_registrations', sessions: 'store_sessions',passwords:'store_passwords'},path: 'stores', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'}
  devise_for :users, :controllers => {registrations: 'user_registrations', sessions: 'user_sessions', confirmations:'user_confirmations',passwords:'user_passwords'},path: 'users', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup'}
  devise_for :admins, :controllers => {registrations: 'admins_registrations', sessions: 'admins_sessions'},path: 'admins', path_names: { sign_in: 'login', sign_out: 'logout'}

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
  get '*path' => redirect('/home/error')
end
