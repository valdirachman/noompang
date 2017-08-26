Rails.application.routes.draw do
  get 'users/index'

  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :profiles

  resources :relationships

  resources :posts do
    member do
      post :repost
    end
  end

  resources :conversations do
    resources :messages
  end

  root 'pages#index'

  get '/home' => 'pages#home_drivers', as: 'home'

  get '/home/ride_requests' => 'pages#home', as: 'home_ride_requests'

  get 'users/sign_in' => 'users/sign_in'

  get 'about/about_us' => 'about#about_us'

  get 'about/faq' => 'about#faq'

  get 'about/safety' => 'about#safety'

  get 'about/team' => 'about#team'

  get 'about/terms_and_conditions' => 'about#terms_and_conditions'

  get 'about/how_it_works' => 'about#how_it_works' , as: 'how_it_works'

  get 'stories' => 'pages#stories'

  get '/user/:id' => 'pages#profile', as: 'user_profile'

  get '/notification' => 'pages#notification', as: 'notification'

  get '/active_rides' => 'pages#active_rides'

  get '/add/:id', to: 'friends#add', as: 'add_friend'

  get '/accept/:id', to: 'friends#accept', as: 'accept_friend'

  get '/friends/:id', to: 'friends#see_friends', as: 'see_friends'

  resources :driver_posts, only: [:create, :destroy]

  post 'driver_posts_with_booking', to: 'driver_posts#create_with_indirect_booking', as: 'driver_posts_with_indirect_booking'
  post 'direct_bookings', to: 'direct_bookings#create', as: 'direct_bookings'
  get 'direct_bookings/:id/accept', to: 'direct_bookings#accept', as: 'accept_direct_booking'
  get 'direct_bookings/:id/reject', to: 'direct_bookings#reject', as: 'reject_direct_booking'

  post 'indirect_bookings', to: 'indirect_bookings#create', as: 'indirect_bookings'
  get 'indirect_bookings/:id/accept', to: 'indirect_bookings#accept', as: 'accept_indirect_booking'
  get 'indirect_bookings/:id/reject', to: 'indirect_bookings#reject', as: 'reject_indirect_booking'

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
