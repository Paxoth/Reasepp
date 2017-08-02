class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    before_action :set_presentation

	private

	def set_presentation
	@events = Event.all
	@interest_links = InterestLink.order("name ASC").all
	end

end

