=begin rdoc
  _**Presentation:** controlador utilizado para desplegar las vistas del portal web.
  Utiliza comunmente información de Section, pero este controlador es solo pensado para vistas específicas de usuarios visitantes, es decir, offline._
=end
class PresentationController < ApplicationController
	before_action :set_presentation, except: [:estatuto]
	add_breadcrumb "Inicio", :root_path
	
	#Vista principal del portal web
	#
	#Muestra las últimas 5 noticias ordenadas por prioridad ( Section ).
	#
	#También realiza la consulta pa mostrar los usuarios registrados en las últimas 2 semanas ( User ).
	#
	#Realiza la consulta de la última acta. ( Resource)
	#
	#Muestra la información del último boletín generado ( Bulletin )
	def index
		@sections = Section.paginate(page: params[:page],per_page: 5).order("priority ASC").where("module = ?","Novedad")
		if user_signed_in?
			@users = User.where("created_at >= ?", 2.week.ago.utc)
			@acta = Resource.where(category: 1).last
			@bulletin = Bulletin.last
		end
	end

	#Vista del módulo ¿Quiénes somos?
	#
	#Se muestras las instituciones adheridas ( Institution )
	#
	#Ademas de las secciones de la categoría "somos" ( Section )
	def somos
		add_breadcrumb "¿Quiénes Somos?", :presentation_somos_path 
		@instituciones = Institution.order("name ASC").all
		@sections = Section.order("priority ASC").where("module = ?","Somos")

	end

	#Vista del módulo ¿Qué hacemos?
	#
	#Se muestras las actas de las últimas asambleas ( Resource )
	#
	#Ademas de las secciones de la categoría "somos" ( Section )
	def hacemos
		add_breadcrumb "¿Qué hacemos?", :presentation_hacemos_path
		@resources = Resource.paginate(page: params[:page],per_page: 10).where(category: 1).order("date DESC")
		@sections = Section.order("priority ASC").where("module = ?","Hacemos")

	end

	#Vista del módulo AprendizajeServicio
	#
	#Muestra las secciones de la categoría "Aprendizaje Servicio" ( Section )
	def aprendizaje
		add_breadcrumb "¿Qué es AS?", :presentation_aprendizaje_path
		@sections = Section.order("priority ASC").where("module = ?","Aprendizaje Servicio")
	end

	#Vista del módulo AprendizajeServicio
	#
	#Muestra las secciones de la categoría "Estatuto" ( Section )
	def estatuto
		add_breadcrumb "Estatuto", :presentation_estatuto_path
		@events = Event.all
    	@interest_links = InterestLink.order("name ASC").all
		@sections = Section.where("module = ?","Estatuto")
	end

	#Vista de las preguntas frecuentes y créditos del sistema
	#
	#Genera las consultas de las preguntas frecuentes ( Question )	
	def about
		add_breadcrumb "Acerca de", :presentation_estatuto_path
		@events = Event.all
    	@interest_links = InterestLink.order("name ASC").all
		@questions = Question.all
	end

	#Vista que permite buscar diferentes consultas a través de un match de palabras, utilizando la función search de diferentes entidades.
	#Divida las consultas tanto para la intranet (user_signed_in?), como para el portal web (!user_signed_in?).
	def searchPage
		add_breadcrumb "Búsqueda"
		if user_signed_in? ##SEARCH PARA LA INTRANET
			@users = User.order("nickname ASC")
			@sections = Section.where("module = ? or module = ?", "Estatuto", "Novedad")
			@resources = Resource.order("created_at DESC").all
			@institutions = Institution.order("name DESC").all
			@interest_links = InterestLink.order("created_at DESC").all
			@requests = Request.order("title ASC").all
			@offerings = Offering.order("title ASC").all
			@services = Service.where("status = 2 or status = 4 or status = 5").order("updated_at DESC")
			@experiences = Experience.order("created_at DESC").all
			if params[:search]
				@users = User.search(params[:search]).order("nickname ASC")
				@sections = Section.search(params[:search]).where("module = ? or module = ?", "Estatuto", "Novedad")
				@resources = Resource.search(params[:search]).order("created_at DESC")
				@institutions = Institution.search(params[:search]).order("name DESC")
				@interest_links = InterestLink.search(params[:search]).order("created_at DESC")
				@requests = Request.search(params[:search]).order("title ASC")
				@offerings = Offering.search(params[:search]).order("title ASC")
				@services = Service.search(params[:search]).where("status = 2 or status = 4 or status = 5").order("updated_at DESC")
				@experiences = Experience.search(params[:search]).order("created_at DESC")			
			else
				@users = User.order("nickname ASC")
				@sections = Section.where("module = ? or module = ?", "Estatuto", "Novedad")
				@resources = Resource.order("created_at DESC").all
				@institutions = Institution.order("name DESC").all
				@interest_links = InterestLink.order("created_at DESC").all
				@requests = Request.order("title ASC")
				@offerings = Offering.order("title ASC")
				@services = Service.where("status = 2 or status = 4 or status = 5").order("updated_at DESC")
				@experiences = Experience.order("created_at DESC").all
			end
		else ##SEARCH PARA EL PORTAL WEB
			@sections = Section.order("created_at DESC").all
			@resources = Resource.where(category: 1).order("created_at DESC").all
			@institutions = Institution.order("name DESC").all
			@interest_links = InterestLink.order("created_at DESC").all
			if params[:search]
				@sections = Section.search(params[:search]).order("created_at DESC")
				@resources = Resource.where(category: 1).search(params[:search]).order("created_at DESC")
				@institutions = Institution.search(params[:search]).order("name DESC")
				@interest_links = InterestLink.search(params[:search]).order("created_at DESC")	
			else
				@sections = Section.order("created_at DESC").all
				@resources = Resource.order("created_at DESC").where(category: 1)
				@institutions = Institution.order("name DESC").all
				@interest_links = InterestLink.order("created_at DESC").all	
			end
		end	
	end
	private

	def set_presentation
		@events = Event.all
		@interest_links = InterestLink.order("name ASC").all
	end
end
