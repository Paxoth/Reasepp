Rails.application.routes.draw do

	match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
	get 'users/listarUsuarios'
	get 'presentation/index'
	get 'presentation/contacto'
	get 'presentation/somos'
	get 'presentation/about'
	get 'events/listado'
	get 'sections/novedades'
	get 'sections/newNovedades'
	get 'sections/institutions'
	get 'sections/areas'
	get 'sections/resources'
	get 'services/index_activos'
	post 'presentation/searchPage'
	post 'requests/searchRequest'
	post 'offerings/searchOffering'
	post 'experiences/searchExperience'
	post 'resources/searchResource'
	post 'events/searchEvent'
	post 'services/searchService'
	post 'questions/searchQuestion'
	

	resources :questions
	resources :sections
	resources :events do
		resources :comments
	end
	resources :offerings do
		resources :comments
		resources :services
	end
	resources :requests do
		resources :comments
		resources :services 
	end
	resources :services, only: [:index,:show]
	resources :services do
		resources :experiences
		resources :comments
	end
	resources :experiences
	resources :institutions
	get 'institutions/:id/managment' => 'institutions#managment', as: :managment
	resources :contacts
	resources :resources
	resources :interest_links
	resources :bulletins, except: [:edit]
	resources :areas
	

	devise_for :users, :controllers => { :registrations => "users/registrations", :omniauth_callbacks => 'users/omniauth_callbacks'}
	match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
	resources :users

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

	devise_scope :user do
	authenticated :user do
		root :to => 'presentation#index'
	end

	unauthenticated :user do
		root :to => 'presentation#index', as: :unauthenticated_root
	  #'devise/sessions#new'
	end

	end

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
