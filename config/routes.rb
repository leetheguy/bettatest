Bettatest::Application.routes.draw do
  root :to				=> 'static#index'
  
  match 'betta_tests'       => 'beta_tests#index'
  match 'about'						  => 'static#about'
  match 'contact'					  => 'static#contact'
  match 'unconfirmed_user'	=> 'static#unconfirmed_user'
  match 'suspended_user'  	=> 'static#suspended_user'
  match 'log_out'           => 'sessions#destroy', :as => 'log_out'
	match 'log_in'            => 'sessions#new', :as => 'log_in'
	match 'sign_up'           => 'users#new', :as => 'sign_up'
	match 'preferences'       => 'users#edit', :as => 'preferences'
  match 'dashboard'			  	=> 'users#show'
#  match 'confirm_email'     => 'users#confirm_email', :as => 'confirm_email', :via => 'get'
 
  resources :beta_tests, :sessions,
            :blogs, :referrals, :subscriptions,
            :forum_categories, :forum_topics, :forum_posts,
            :surveys, :survey_options,
            :tester_stat_sheets, :tickets, :ticket_categories

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
