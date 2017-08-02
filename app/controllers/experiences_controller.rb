class ExperiencesController < ApplicationController
	before_action :authenticate_user!
	before_action :setExperience

	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Experiencias", :experiences_path

	def index
	end
	def searchExperience
		add_breadcrumb "Búsqueda"
	    if params[:search]
	      @offerings = Offering.where("status = ?", 3).search(params[:search])
	      @requests = Request.where("status = ?", 3).search(params[:search])
	    else
			@offerings = Offering.where("status = ?", 3)
			@requests = Request.where("status = ?", 3)
	    end
	end
	
	private
	def setExperience
		@offerings = Offering.where("status = ?", 3)
		@requests = Request.where("status = ?", 3)
	end
end
