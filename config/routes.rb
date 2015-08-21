Rails.application.routes.draw do


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :users, only: [:index, :create, :show]

  resources :products, except: [:destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :categories, except: [:edit, :update, :destroy]

  resources :orders, except: [:destroy, :new, :create]

  resources :order_items, only: [:edit, :update]


  get    "/cart" => 'order_items#index', as: 'cart'
  get    "/cart/:product_id/new" => 'order_items#new', as: 'new_item'
  post   "/cart" => 'order_items#create', as: 'order_items'
  post   "/cart" => 'order_items#create'
  patch  "/cart/:id/edit" => 'order_items#edit', as: 'edit_item'
  delete "/cart/:id" => 'order_items#destroy', as: 'delete_item'

  post   "/receipt" => 'orders#update'

  get    "/signup" => 'users#new', as: 'signup'
  get    "/login" => 'sessions#new', as: 'login'
  post   "/login" => 'sessions#create'
  delete "/logout" => 'sessions#destroy', as: 'logout'

  get "/dashboard/:id" => 'users#dashboard', as: 'dashboard'
  get "/dashboard/:id/orders" => 'orders#index', as: 'dashboard_orders'
  get "/dashboard/:id/orders/:order_id" => 'orders#show', as: 'dashboard_order_show'
  patch "/cart" => 'order_items#quantity_update', as: 'quantity_update'

  # get '/shipping/:order_id/review' => "orders#review", as: 'review'
  get '/shipping/:order_id' =>  'orders#shipping_rates', as:'shipping_rates'



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
