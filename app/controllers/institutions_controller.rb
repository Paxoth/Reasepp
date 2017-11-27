=begin rdoc
  _**Institution:** controlador de las instituciones (Ver Institution)_
=end
class InstitutionsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :set_institution, only: [:show, :edit, :update, :destroy, :managment]
	before_action :validate_category, except: [:show,:index,:new,:create]
	before_action :set_breadcrumbs


	#Vista principal
	#
	#Genera las consulta de todas las insituciones paginadas en grupos de 15 elementos, ordenads por nombre.
	def index
		@institutions = Institution.paginate(page: params[:page],per_page: 15).order("name ASC").all
	end

	#Vista principal de las experiencias
	#
	#Se realizan las consultas de todos los usuarios clasificados por categoría (Ver User).
	#
	#Se muestra la información sobre el encargado AS (manager).
	#
	#Se muestran los datos de las experiencias y los impactos que han generado dentro de las comunidades y estudiantes.
	def show
		add_breadcrumb @institution.name, @institution 
		@professors = @institution.users.where(category: 2)
		@brokers = @institution.users.where(category: 3)
		@partners = @institution.users.where(category: 4)
		if @institution.manager_id.present?
			@manager = User.where(id: @institution.manager_id).first
		end
		@offerings = @institution.offerings.where(status: 1)
		@impacto = Experience.sum("benefited")
		@requests = @institution.requests.where(status: 1)
		@experiences = @institution.experiences
	end

	#Vista nueva institución
	#Solo puede ser accedida por un administrador
	def new
		add_breadcrumb "Nueva institucion"
		@institution = Institution.new
	end

	#Vista de editar institución
	#Solo puede ser accedida por un encargado AS
	def edit
		add_breadcrumb "Editar", institutions_path
	end

	#Método para crear institución utilizando los parámetros establecidos.
	#
	#Generado automáticamente por scaffold.
	def create

		@institution = Institution.new(institution_params)

		respond_to do |format|
			if @institution.save
				format.html { redirect_to @institution, notice: 'La institución se ha creado exitosamente.' }
				format.json { render :show, status: :created, location: @institution }
			else
				format.html { render :new }
				format.json { render json: @institution.errors, status: :unprocessable_entity }
			end
		end
	end

	#Método para actualizar institución utilizando los parámetros establecidos.
	#
	#Generado automáticamente por scaffold.
	def update
		respond_to do |format|
			if @institution.update(institution_params)
				format.html { redirect_to @institution, notice: 'La institución se ha modificado exitosamente' }
				format.json { render :show, status: :ok, location: @institution }
			else
				format.html { render :edit }
				format.json { render json: @institution.errors, status: :unprocessable_entity }
			end
		end
	end

	#Método para actualizar institución utilizando los parámetros establecidos.
	#
	#Generado automáticamente por scaffold. No utilizado.
	def destroy # :nodoc:
		@institution.destroy
		respond_to do |format|
			format.html { redirect_to institutions_url, notice: 'La institución se ha eliminado.' }
			format.json { head :no_content }
		end
	end

	#Vista de información para la gestión
	#
	#Vista utilizada para la realización de consultas específicas por fecha sobre la institución y sus respectivas experiencias realizadas.
	#Genera las consultas de las áreas de trabajo ( Area ) para clasificación de las experiencias ( Experience )
	def managment
		add_breadcrumb @institution.name, @institution
		add_breadcrumb "Información", managment_path(@institution)
		@fecha_inicio = params[:fecha_inicio]
		@fecha_termino = params[:fecha_termino]
		if(@fecha_inicio.present? and @fecha_termino.present?)
			@experiences = @institution.experiences.created_between(@fecha_inicio.to_date,@fecha_termino.to_date);
			@areas = Area.all
		end
		
	end


	private

		#Añade breadcrumbs al sitio dependiendo del tipo de usuario que esté conectado.
		def set_breadcrumbs # :doc:
			add_breadcrumb "Inicio", :root_path
			if !user_signed_in?
				add_breadcrumb "¿Quiénes somos?", :presentation_somos_path
				
			else
				add_breadcrumb "Instituciones", institutions_path
			end
		end

		#Valida que solo un administrador pueda crear una institución.
		#Valida que solo el encargado AS (manager_id) pueda operar sobre varias vistas de la institución.
		def validate_category # :doc:
			if !@institution.manager_id.blank?
				if current_user.id != @institution.manager_id
					redirect_to root_path, alert: "Sólo el encargado AS puede trabajar sobre esta institución."
				end
			elsif !current_user.is_admin?
				redirect_to root_path, alert: "Solo un admin puede trabajar sobre las insituciones, mientras no haya encargado AS."
			end
		end

		def set_institution
			@institution = Institution.find(params[:id])
		end

		def institution_params
			params.require(:institution).permit(
				:name, 
				:web, 
				:logo, 
				:manager_id)
		end
end
