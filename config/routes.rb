Rails.application.routes.draw do
	get 'users/listarUsuarios'
	get 'presentation/index'
	get 'presentation/contacto'
	get 'presentation/somos'
	get 'presentation/hacemos'
	get 'presentation/aprendizaje'
	get 'presentation/estatutos'
	post 'presentation/searchPage'
	get 'events/listado'
	get 'sections/somos'
	get 'sections/hacemos'
	get 'sections/aprendizaje'
	get 'sections/estatutos'
	get 'sections/novedades'
	get 'sections/linkInteres'
	get 'sections/newHacemos'
	get 'sections/newSomos'
	get 'sections/newEstatutos'
	get 'sections/newAprendizaje'
	get 'sections/newNovedades'
	post 'requests/searchRequest'
	post 'offerings/searchOffering'
	post 'experiences/searchExperience'
	resources :experiences, only:[:index]

	resources :sections
	resources :events do
		resources :comments
	end
	resources :offerings do
		resources :comment_offerings
	end
	resources :requests do
		resources :comment_requests
	end
	resources :institutions
	resources :contacts
	resources :minutes
	resources :interest_links
	resources :bulletins, except: [:edit]
	resources :areas
	
	
	###:controllers => { :registrations => "users/registrations" }
	### preguntar qué realmente significa esto.

	devise_for :users, :controllers => { :registrations => "users/registrations" }
	resources :users, only: [:index, :show, :edit, :update]

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
