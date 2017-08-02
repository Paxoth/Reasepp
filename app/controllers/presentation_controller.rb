class PresentationController < ApplicationController
	before_action :set_presentation, except: [:estatutos]
	add_breadcrumb "Inicio", :root_path
	
	def index
		@sections = Section.order("priority ASC").where("module = ?","Novedad")
		if user_signed_in?
			@users = User.where("created_at >= ?", 2.week.ago.utc)
			@minute = Minute.last
		end
	end

	def searchPage
		add_breadcrumb "Búsqueda"
		if params[:search]
			if user_signed_in?
				@sections = Section.search(params[:search]).where("module = ?", "Estatutos")
				@requests = Request.search(params[:search]).order("title ASC")
				@offerings = Offering.search(params[:search]).order("title ASC")
				@users = User.search(params[:search]).order("nickname ASC")
			else
				@sections = Section.search(params[:search]).order("created_at DESC")
			end
			@interest_links = InterestLink.search(params[:search]).order("created_at DESC")
			@events = Event.search(params[:search]).order("created_at DESC")
			@minutes = Minute.search(params[:search]).order("created_at DESC")
			@institutions = Institution.search(params[:search]).order("created_at DESC")
		else
			@interest_links = InterestLink.all.order('name ASC')
			@events = Event.all.order('end_time DESC')
		end
	end
	def somos
		add_breadcrumb "¿Quiénes Somos?", :presentation_somos_path 
		@instituciones = Institution.order("name ASC").all
		@sections = Section.order("priority ASC").where("module = ?","Somos")

	end

	def hacemos
		add_breadcrumb "¿Qué hacemos?", :presentation_hacemos_path
		@minutes = Minute.order("created_at DESC").all
		@sections = Section.order("priority ASC").where("module = ?","Hacemos")

	end

	def aprendizaje
		add_breadcrumb "¿Qué es A+S?", :presentation_aprendizaje_path
		@sections = Section.order("priority ASC").where("module = ?","Aprendizaje Servicio")
	end

	def estatutos
		add_breadcrumb "Estatutos", :presentation_estatutos_path
		@events = Event.all
    	@interest_links = InterestLink.order("name ASC").all
		@sections = Section.where("module = ?","Estatutos")
	end

	private

	def set_presentation
		@events = Event.all
    	@interest_links = InterestLink.order("name ASC").all
	end
end
