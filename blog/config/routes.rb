Rails.application.routes.draw do
  

  get 'departments/index'

  get 'departments/new'

  get 'departments/create'

  get 'departments/destroy'

  get 'departments/edit'

  get 'departments/update'

  resources :activities, :users, :departments

  get '/login' => 'welcome#index'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get 'recover_password' => 'welcome#recover_password'
  get 'change' => 'users#change'
  get 'guide' => 'welcome#guide'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get 'index' => 'users#index'


  post 'actions/create' => 'actions#create' 
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'




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
