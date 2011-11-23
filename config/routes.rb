Bettatest::Application.routes.draw do
#  devise_for :users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to                      => 'static#index'
  
  match 'betta_tests'           => 'beta_tests#index'
  match 'contact'               => 'static#contact'
  match 'unconfirmed_user'      => 'static#unconfirmed_user'
  match 'suspended_user'        => 'static#suspended_user'
  match 'resend_confirmation'   => 'static#resend_confirmation'
  match 'terms'                 => 'static#terms_of_service'
  match 'log_out'               => 'sessions#destroy', :as => 'log_out'
  match 'log_in'                => 'sessions#new', :as => 'log_in'
  match 'possess'               => 'sessions#possess', :as => 'possess'
  match 'sign_up'               => 'users#new', :as => 'sign_up'
  match 'preferences'           => 'users#edit', :as => 'preferences'
  match 'dashboard'             => 'users#show'
  match 'manual_test_list'      => 'static#manual_test_list'
  match '/feed'                 => 'blogs#feed',
        :as                     => :feed,
        :defaults               => { :format => 'atom' }
  match 'sitemap'               => 'sitemap#show'
  match 'stripe_hook'           => 'subscriptions#stripe_hook', :via => :post
  
#  match 'confirm_user'          => 'users#confirm', :as => :confirm, :via => :get

  match 'about'                 => 'static#about'
  match 'subscription'          => 'static#subscription'
  match 'overview'              => 'static#overview'
  match 'game'                  => 'static#game'
  match 'developer'             => 'static#developer'
  match 'company'               => 'static#company'
 
  match 'send_contact'          => 'static#send_contact'
  resources :sessions, :surveys, :survey_options, :forum_categories, :forum_topics, :ticket_categories, :tickets, :tester_stat_sheets, :referrals, :subscriptions, :leaders, :beta_tests, :subscriptions

  resources :forum_posts do
    get 'rate_up', :on => :member
    get 'rate_down', :on => :member
  end
  
  resources :blogs do
    get :unpublished, :on => :collection
  end

  resources :users do
    get 'confirm', :on => :member
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
