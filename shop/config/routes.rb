Rails.application.routes.draw do
  get 'seller_graph/index'

  get 'product/index'
  get 'mypage' => 'mypage#index'
  delete 'mypage' => 'mypage#delete_mypage'
  get 'seller_mypage' => 'mypage#seller_index'
  delete 'seller_mypage' => 'mypage#delete_seller_mypage'
  get 'delete_end' => 'mypage#delete_end'
  get 'mileage' => 'mypage#mileage'
  get 'recent' => 'mypage#recent'
  get 'user_deal' => 'mypage#user_deal'
  patch 'user_deal' => 'mypage#user_deal_update'

  get 'idpw_search' => 'idpw_search#index'
  get 'id_search' => 'idpw_search#id_search'
  post 'id_search_result' => 'idpw_search#id_search_result'
  get 'pw_search' => 'idpw_search#pw_search'
  post 'pw_search_result' => 'idpw_search#pw_search_result'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'category_main' => 'category_main#index'
  get 'notice_main' => 'notice_main#index'
  delete 'notice_main' => 'notice_main#destroy'
  get 'notice_QnA' => 'notice_main#new'
  post 'notice_QnA' => 'notice_main#create'

  get 'buy' => 'buy#index'
  get 'buy_new' => 'buy#new'
  post 'buy_new' => 'buy#create'

  get 'shoppingbag' => 'shoppingbag#index'
  post 'shoppingbag' => 'shoppingbag#create'
  get 'shoppingbag_delete' => 'shoppingbag#destroy'

  get 'admin_home' => 'admin_home#index'
  get 'manage_member' => 'admin_manage#member_index'
  post 'manage_member' => 'admin_manage#search_member'
  delete 'manage_member' => 'admin_manage#destroy_member'
  get 'manage_notice' => 'admin_manage#notice_index'
  post 'manage_notice' => 'admin_manage#search_notice'
  delete 'manage_notice' => 'admin_manage#destroy_notice'

  get 'new_join' => 'join#new'

  get 'seller_graph' => 'seller_graph#index'
  get 'seller_graph2' => 'seller_graph#index2'
 
  get 'seller_article' => 'seller_article#index'
  patch 'seller_article' => 'seller_article#update'

  get 'seller_return' => 'seller_return#index'
  patch 'seller_return' => 'seller_return#update'

  resources :join
  resources :home
  resources :product
  resources :seller_deal
  resources :seller_home
  resources :seller_notice
#resources :seller_article

  root 'home#index'
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
