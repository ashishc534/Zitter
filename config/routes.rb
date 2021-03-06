Rails.application.routes.draw do
  devise_for :users
  resources :posts
  resources :relationships
 
  root 'pages#index'
  post 'toggle' => 'likes#toggle_like'
  get '/home' => 'pages#home'
  get '/search' => 'posts#search'
  post 'user/pages/relation' => 'pages#relation'
  get '/user/:id' => 'pages#profile'
  get '/user/:id/following' => 'pages#following'
  get '/user/:id/followers' => 'pages#followers'
  get '/user/:id/likes' => 'pages#likes'
  post '/user/:id/pages/relation' => 'pages#relation'
  post '/theme_submit' => 'pages#theme_submit'
  post '/new' => 'comments#new'
  get '/comments' => 'comments#comment'
  get '/theme' => 'pages#theme'
  get '/explore' => 'pages#explore'
  get '/upload_image' => 'pages#upload_image'
  get '/upload_cover_image' =>'pages#upload_cover_image'
  post '/upload_image_submit' => 'pages#upload_image_submit'
  post '/upload_cover_image_submit' => 'pages#upload_cover_image_submit'
  
  get '/pages/developer'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  #     #     resources :sales do
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
