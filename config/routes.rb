
MiniLegions::Application.routes.draw do
  devise_for :users
  resources :users do
    resources :collections
    resources :imagevotes
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :miniatures do
    collection do
    get :manufacturers
    get :scales
    get :sculptors
    get :collections
    get :lines
    get :contents
    post :import
    end
    member do
      get :minisets, :setminis
      get :clone
    end
  end
  resources :manufacturers do
    collection do
      get :miniatures
      get :lines
    end
  end
  resources :lines do
   collection do
    get :manufacturers
    get :miniatures
   end
  end
  resources :productions
  resources :versions
  resources :imagevotes
  resources :sizes
  resources :minilines
  resources :contents
  resources :scales
  resources :sculptors do
    collection do
      get :miniatures
    end
  end
  resources :collections do
    member do
      get :miniatures
      get :users
      get :imagevotes
    end
  end

  root  'static_pages#home'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/getting_started', to: 'static_pages#getting_started', via: 'get'
  match '/add_to_collection', to: 'static_pages#add_to_collection', via: 'get'
  match '/how_to_vote', to: 'static_pages#how_to_vote', via: 'get'
  match '/new',     to: 'miniatures#new',       via: 'get'
  match 'reply_form', to: 'microposts#_reply_form', via: 'get'
  match 'in_collection', to: 'miniatures#in_collection', via: 'get'
  post 'versions/:id/revert' => 'versions#revert', :as => 'revert_version'
  match 'clone', to: 'miniatures#clone', via: 'get'
  

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
