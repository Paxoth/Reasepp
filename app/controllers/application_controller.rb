class ApplicationController < ActionController::Base
	before_filter :ensure_signup_complete, only: [:new, :create, :update, :destroy]
	
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    before_action :set_presentation

	private

	def set_presentation
		@events = Event.all
		@interest_links = InterestLink.order("name ASC").all
	end

	def ensure_signup_complete
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

