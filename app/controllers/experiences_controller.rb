=begin rdoc
  _**Experience:** controlador de las Experiencias (Ver Experience)_
=end
class ExperiencesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_realizado
	before_action :set_experience, only: [:update, :destroy]
	before_action :set_institutionsAndAreas
	before_action :validate_category, except: [:show, :index, :searchExperience]
	before_action :set_broker, only: [:new, :edit, :create]


	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Actividades AS"
	add_breadcrumb "Experiencias", :experiences_path

	#Vista principal
	#
	#Genera la consulta de las experiencias paginadas de a 30 elementos.
	def index
		@experiences =Experience.all
	end

	#Vista nueva experiencias
	#
	#Permite crear uan experiencia, basada un un servicio anteriormente generado. Las experiencias, siempre provienen de un servicio.
	#En caso de que no provenga de un servicio se pueden generar experiencias documentadas (Ver Project)
	def new
		@service = servicio
		@experience = @service.experiences.new
	end

	#Vista de editar experiencias
	#
	#Permite editar expereincias de acuerdo a los parametros establecidos.
	#Impide que un usuario que no sea el profesor creador del servicio padre pueda generar la experiencia.
	def edit
		add_breadcrumb "Editar"
	    @service = servicio
	    @experience = servicio.experiences.find(params[:id])
	    if current_user != @experience.professor
	    	redirect_to root_path, alert: "Solo el profesor dueño de esta experiencia puede editarla."
	    end
	end

	#Vista específica
	#
	#Permite mostrar los datos de una experiecias buscada por ID.
	#También se pueden generar un pdf con la inforḿación de la experiencia (Ver ExperiencePdf)
	def show
		@experience = Experience.find(params[:id])
		if @experience.broker_id.present?
			@broker = User.where(id:@experience.broker_id).first
		end

		add_breadcrumb "Mostrando "+@experience.title
		respond_to do |format|
			format.html
			format.pdf  do
				pdf = ExperiencePdf.new(@experience)
				send_data pdf.render, :filename => "Experiencia_#{@experience.id}.pdf", 
									:type => 'application/pdf',
									:disposition => 'inline'
									
			end
		end
	end

	#Crear Experiencia
	#
	# Método que permite crear una experiencia basada en un servicio (NestedResource)
	# Se preocupa de ver si la experiencia viene de una oferta o una solicitud para decidir quién es el responsable. 
	# El profesor siempre debe ser responsable de las experiencias.
	def create
		@service = servicio
		@experience = @service.experiences.new(experience_params)
		@experience.professor = current_user
		if @service.publication_type == "Offering"
			@experience.partner = @service.creator
		else
			@experience.partner = @service.acceptor
		end
		if @broker.present?
			@experience.broker_id = @broker.id
		end
		respond_to do |format|
			if @experience.save
				@service.update(status: 5)
				format.html { redirect_to experience_path(@experience), notice: 'La experiencia se ha creado exitosamente.' }
				format.json { render :show, status: :created, location: @experience }
			else
				format.html { render :new }
				format.json { render json: @experience.errors, status: :unprocessable_entity }
			end
		end
	end

	#Actualizar experiencia
	#
	#Permite actualizar los datos de la experiencia.
	def update
	    @service = servicio
	    @experience = @service.experiences.find(params[:id])
		respond_to do |format|
			if @experience.update(experience_params)
				format.html { redirect_to experience_path(@experience), notice: 'La experiencia se ha modificado exitosamente.' }
				format.json { render :show, status: :ok, location: @experience }
			else
				format.html { render :edit }
				format.json { render json: @experience.errors, status: :unprocessable_entity }
			end
		end
	end

	#Permite eliminar una experiencia. Generada automáticamente por scaffold.
	def destroy
		@experience.destroy
		respond_to do |format|
			format.html { redirect_to servicio_url(servicio), notice: 'La experiencia se ha eliminado.' }
			format.json { head :no_content }
		end
	end

	#Vista que permite buscar experiencias a través de un match de palabras, utilizando la función search.
	#La busqueda complementa tanto las experiencias como las experiencias documentadas ( Project )
	#
	#*NOTA IMPORTANTE:* a pesar de que esta vista funciona de manera correcta, fue quitada por Maximiiano Pérez porque la búsuqeda de DataTables es suficientemente eficiente.
	def searchExperience
		add_breadcrumb "Búsqueda"
		@experiences = Experience.order("created_at DESC").all
		@projects = Project.order("created_at DESC").all
		if params[:search]
			@experiences = Experience.search(params[:search]).order("created_at DESC")
			@projects = Project.search(params[:search]).order("created_at DESC")
		else
			@experiences = Experience.order("created_at DESC").all
			@projects = Project.order("created_at DESC").all
		end
	end
	
	private

	#Busca los servicios de acuerdo al ID obtenido del URL
    def servicio # :doc
        id = params[:service_id]
        Service.find(params[:service_id])     
    end 

    #Valida que solo un profesor puede trabajar sobre la experiencia.
	def validate_category # :doc
		if current_user.category != 2
			redirect_to root_path, alert: "Sólo un profesor puede trabajar las experiencias."
		end   
	end

	#Realiza la consulta de las actividades AS que estén en un estado de realizado.
	def set_realizado # :doc
		@offerings = Offering.where("status = ?", 3)
		@requests = Request.where("status = ?", 3)
	end

	def set_experience
		@experience = Experience.find(params[:id])
    end

    #Realiza las consultas de todas las Institution y Area para la clasificación de las experiencias.
    def set_institutionsAndAreas # :doc
    	@institutions = Institution.all
    	@areas = Area.order("discipline ASC").order("name ASC").all	
    end

    # Busca si el servicio padre de la experiencia posee un vinculador social.
    # De ser así realiza la consulta para tenerlo en parametros.
	def set_broker # :doc
		if servicio.broker_id.present?
			@broker = User.where(id:servicio.broker_id).first
		end
	end
    
    def experience_params
      params.require(:experience).permit(
      		:area_id,
      		:service_id,
			:description,
			:partner_id,
			:professor_id,
			:broker_id,
			:folio,
			:institution_id,
			:faculty,
			:department,
			:course_name,
			:course_type,
			:course_type_other,
			:period,
			:professor_phone,
			:professor_degree,
			:learning_objectives,
			:service_objectives,
			:frequency,
			:weekly_hours,
			:participants,
			:students_level,
			:community_partner,
			:organization_type,
			:benefited,
			:results,
			:tools,
			:reflection_moments,
			:title)
    end
end
