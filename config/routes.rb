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
  get '/stores/orders', to: 'stores#orders', as: 'store_orders'
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
  post 'stores/update_password' => 'stores#update_password'
  post 'products/add_variant' => 'products#add_variant'
  post 'products/add_variant_temp' => 'products#add_variant_temp'
  post 'products/delete_variant' => 'products#delete_variant'
  post 'products/delete_variant_temp' => 'products#delete_variant_temp'
  post 'products/append_variant' => 'products#append_variant'
  post 'products/append_variant_temp' => 'products#append_variant_temp'
  post '/products/collect_vars/(:id)' => 'products#collect_vars'
  post '/products/final_variants' => 'products#final_variants'
  get 'stores/analytics' => 'stores#analytics'
  post 'stores/update_tag' => 'stores#update_tag'
  get 'admins/upgrade/:id' => 'admins#upgrade', as: 'admins_upgrade'
  get 'admins/downgrade/:id' => 'admins#downgrade', as: 'admins_downgrade'
  put 'admins/own_domain/:id' => 'admins#own_domain', as: 'admins_own_domain'
  get 'stores/premium' => 'stores#premium', as: 'stores_premium'
  post 'stores/create_year' => 'stores#create_year'
  post 'stores/create_bi' => 'stores#create_bi'
  post 'stores/create_month' => 'stores#create_month'
  post 'stores/confirm_sub' => 'stores#confirm_sub'
  get 'admins/allemails' => 'admins#allemails'
  get 'products/duplicate/(:id)' => 'products#duplicate', as: 'products_duplicate'
  get 'stores/feedback' => 'stores#feedback'
  put 'stores/send_feed' => 'stores#send_feed'
  get 'admins/feedback' => 'admins#feedback'
  get 'admins/ipns' => 'admins#ipns'
  get 'admins/transactions' => 'admins#transactions'
  get 'admins/transfers' => 'admins#transfers'
  get 'admins/subscriptions' => 'admins#subscriptions'
  get 'admins/earnings' => 'admins#earnings'
  get '/legal/terms' => 'home#terms'
  get '/legal/aup' => 'home#aup'
  post 'ipn/ipay' => 'ipn#ipay'
  post 'stores/ib2c_mpesa' => 'stores#ib2c_mpesa'
  post 'stores/ib2c_airtel' => 'stores#ib2c_airtel'
  post 'stores/ib2b_paybill' => 'stores#ib2b_paybill'
  post 'stores/ib2b_till' => 'stores#ib2b_till'
  get 'ipn/process_ipn' => 'ipn#process_ipn'



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
