=begin rdoc
Controlador principal de la plataforma padre del resto de los controladores.

=end
class ApplicationController < ActionController::Base
	before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
	before_action :set_presentation
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	private

	#Método que genera las consultas sobre eventos y links de interés que son mostrados en la barra lateral derecha en todas las vistas.
	#(Ver Event y InterestLink)
	def set_presentation #:doc:
		@events = Event.all
		@interest_links = InterestLink.order("name ASC").all
	end

	#Método que impide que un usuario navegue por la intranet, en caso de no haber confirmado su correo electrínico. (Ver User)
	def ensure_signup_complete #:doc:
		# Ensure we don't go into an infinite loop
		return if action_name == 'finish_signup'

		# Redirect to the 'finish_signup' page if the user
		# email hasn't been verified yet
		if current_user && !current_user.email_verified?
			flash[:alert] = "Aún su cuenta no ha sido confirmada"
			redirect_to finish_signup_path(current_user)
		end
	end
end

