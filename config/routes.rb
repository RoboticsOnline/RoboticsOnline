RoboticsOnline::Application.routes.draw do

  resources :pictures

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'robotics_online#index'
  get "robotics_online/index", :as => :home
  get 'battles' => 'battles#index', :as => :battles
  get 'guilds' => 'guilds#index', :as => :guilds
  get 'friends' => 'friends#index', :as => :friends
  get 'team' => 'team#index', :as => :team
  get 'contacts' => 'contacts#index', :as => :contacts
  get 'game_rules' => 'game_rules#index', :as => :game_rules
  get 'user/vipzone' => 'user#vipzone'
  
  get '/messages/new/reply/:id' => 'messages#new_reply', as: 'message_reply'
  get '/messages/show/inbox/:id' => 'messages#showInbox', as: 'show_inbox'
  get '/messages/show/outbox/:id' => 'messages#showOutbox', as: 'show_outbox'
  get 'messages' => 'messages#index', :as => :messages
  
  get 'ranklist' => 'ranklist#index', :as => :ranklist
  get 'ranklist/page' => 'ranklist#page', :as => 'ranklist_page'
  get 'user' => 'user#index', :as => :user
  get 'admin' => 'admin#index', :as => :admin
  get '/battle/show/:id' => 'battles#show', as: 'show_battle'
  get '/battle/page' => 'battles#page', :as => 'battle_page'
  get '/profile/:username' => 'user#show', as: 'show_user'
  get '/battlefield/user/:username' => 'user#battlefield', as: 'battlefield_user'
  get '/battlefield/mob/:id' => 'user#battlefield', as: 'battlefield_mob'
  get '/messages/inbox/page' => 'messages#page', :as => 'messages_page'

  controller :ranklist do
    get 'sort_by' => :sort_by
  end

  controller :messages do
    get 'messages/index' => :index
    get 'messages/:id/show' => :show
    get 'messages/new' => :new
    get 'messages/ticket' => :ticket
    post 'messages/new' => :create
    post 'messages/ticket' => :ticket_create
    post 'messages/new/reply/:id' => :reply
    
    get 'messages/inbox' => :inbox
    get 'messages/outbox' => :outbox

    get 'messages/show/inbox' => :showInbox
    get 'messages/show/outbox' => :showOutbox
  end
  
  controller :admin do
    get 'admin/index' => :index 
    get 'admin/users' => :users
    post 'admin/ban' => :ban
    post 'admin/unban' => :unban
    get 'admin/items' => :items
    get 'admin/mobs' => :mobs
  end

  controller :user do 
    get 'set_stat' => :set_stat
    post 'get_consumables' => :get_consumables
    get 'consumables_shop' => :consumables_shop
    get 'main_battle' => :main_battle
    get 'battlefield' => :battlefield
    get 'battlefield_list' => :battlefield_list
    get 'fight' => :fight
    get 'messages' => :messages
    get 'general_shop' => :general_shop
    get 'vipzone' => :vipzone
    get 'change_picture' => :change_picture
    get 'set_picture' => :set_picture
    get 'change_password' => :change_password
    get 'search' => :search
    post 'search' => :search

    post 'user/success_transaction1' => :success_transaction1
    post 'user/canceled_transaction1' => 'user#canceled_transaction1'

    post 'user/success_transaction2' => :success_transaction2
    post 'user/canceled_transaction2' => 'user#canceled_transaction2'

    post 'user/success_transaction3' => :success_transaction3
    post 'user/canceled_transaction3' => 'user#canceled_transaction3'
  end

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
