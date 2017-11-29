=begin rdoc
  _**Service:** controlador de los servicios (Ver Service)_
  
  _Service es el resultado de cuando un Offering o un Request son aceptados tanto por el profesor y el socio comunitario ( User )._
  
  _Service parte como un mensaje anidado a la publicación anterior, el cual en caso de que se concrete el profesor llena los demás campos._

  _Muchos servicios son rechazados, por lo que pueden existir y nunca ser utilizados, aún así dejan registro._

=end
class ServicesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_service, only: [:update, :destroy]
	before_action :set_status, only: [:index, :update, :create]
	before_action :validate_category_new, only: [:new]
	before_action :validate_professor , only: [:edit,:destroy]
	before_action :validate_owner, only: [:new]


	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Actividades AS"
	add_breadcrumb "Servicios", :services_index_activos_path
	
	#Vista principal de mensajes
	#
	#Al ser anidada a una publicación se pueden ver los mensajes de manifestaciones de interés por parte de los usuarios por trabajar juntos.
	def index
	end

	#Vista principal de servicios activos
	#
	#Vista en donde se mostrarán todos los servicios activos, aceptados por ambos usuarios ( User )
	def index_activos
		@activos = Service.paginate(page: params[:page],per_page: 5).where(status: 4).order("updated_at DESC")
	end

	#Vista específica
	#
	#Vista en donde se podrá ver los datos del servicio.
	#Se hace las consultas de las experiencias relacionadas al servicio, para mostrarlas en caso de existir.
	def show
		@comment = Comment.new
		@service = Service.find(params[:id])
		@experience = @service.experiences.last
		add_breadcrumb "Mostrar"
		if @service.broker_id.present?
			@broker = User.where(id:@service.broker_id).first
		end
	end

	#Vista nuevo servicio
	#
	#Basada en una publicación previa ( Offering y Request ).
	#
	#Se debe considerar que se crea un service en forma de mensaje el cual pertenece a la publicación previa.
	def new
		@publication = publication
		@service = @publication.services.new
		if @publication.services.where(:creator_id => current_user.id).present?
			redirect_to publication_url(publication), alert: "Ya ha generado una petición para esta publicación"
		end

		add_breadcrumb "Solicitar participación"
	end

	#Editar servicio
	#
	#Para editar servicio depende mucho del tipo de usuario ( User category) que perenezca.
	#
	#Los servicios creados por socios comunitarios, solo pueden editarse cuando esten en forma de mensaje.
	#
	#Los servicios cuando estan en estado activo, solo pueden editarlos profesores.
	def edit
		add_breadcrumb "Editar servicio"
		@publication = publication
		@service = publication.services.find(params[:id])
		if current_user.category != 2
			redirect_to root_path, alert: "Usted no es profesor. No puede editar esta servicio"
		else
			if @service.status == 1 or @service.status == 3
				if Offering === publication
					if publication.user != current_user
						redirect_to root_path, alert: "Usted no es el dueño de la oferta, no puede aceptar esta petición"
					end
				end
			elsif @service.status == 2 or @service.status == 4
				if Request === publication
					if @service.creator != current_user
						redirect_to root_path, alert: "Usted no es el profesor responsable de este servicio"
					end
				else 
					if @service.acceptor != current_user
						redirect_to root_path, alert: "Usted no es el profesor responsable de este servicio"
					end
				end
			end				
		end
	end

	#Método crear servicio
	#
	#Cuando se crea el servicio se toman los datos del usuario y las publicación previa para rellenar los campos iniciales.
	#
	#Recordar que los servicios comienzan como mensaje.
	def create
		@publication = publication
		@service = @publication.services.new(service_params)
		@service.creator = current_user
		@service.title = @publication.title
		@service.area = @publication.area
		@service.description = @publication.description
		@service.resume = @publication.resume
		@service.start_time = Time.now
		@service.end_time = Time.now
		@service.status = 1 #el servicio es solo una petición pendiente.
		if @publication.broker_id.present?
			@service.broker_id = @publication.broker_id
		end

		respond_to do |format|
			if @service.save
				format.html { redirect_to publication_url(publication), notice: 'Se ha enviado su interés de trabajo.' }
				format.json { render :show, status: :created, location: @service }
			else	
				format.html { render :new }
				format.json { render json: @service.errors, status: :unprocessable_entity }
			end
		end
	end

	#Método actualizar servicio
	#
	#Cuando se hace el match entre el profesor y el socio comunitario, el profesor debe poder editar el servicio con los respectivos datos de este.
	# Para ello es que se validan las fechas, y se cambian los estados de las publicaciones previas a "servicio".
	def update
		@publication = publication
		@service = @publication.services.find(params[:id])
			respond_to do |format|
			if @service.update(service_params)
				if @service.end_time + 1.minutes < @service.start_time
					@service.update(end_time: @service.start_time) 
					flash[:alert] = "La fecha de término no puede ser menor a la de inicio, esta se ha modificado automáticamente"
				end
				if@service.status == 3
					format.html { redirect_to publication_url(publication), notice: 'Se ha rechazado la manifestación de interés de trabajo.' }
				elsif @service.status == 2
					format.html { redirect_to publication_url(publication), notice: 'Se ha aceptado la manifestacion de interés de trabajo. El profesor responsable puede modificar el servicio activo.' }
					@publication.update(status: 4) #Cambia el estado de la oferta/solicitud a servicio.
					@service.update(status: 4)
				elsif @service.status == 4
					format.html { redirect_to service_path(@service), notice: 'El servicio se ha editado correctamente.' }
				end
				format.json { render :show, status: :ok, location: @service }
			else
				format.html { render :edit }
				format.json { render json: @service.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy # :nodoc:
		@service.destroy
			respond_to do |format|
			format.html { redirect_to services_url, notice: 'El servicio se ha eliminado correctamente.' }
			format.json { head :no_content }
		end
	end

	#Vista para realizar búsquedas de servicios activos a través del método search ( Service ).
	def searchService
		add_breadcrumb "Búsqueda"
		@service = Service.where(status: 2).order("created DESC")
		if params[:search]
			@services = Service.search(params[:search]).order("updated_at DESC")
		else
			@service = Service.where(status: 2).order("created DESC")
		end
	end

	private

		#Como Service está anidado a una publicación (NestedResource) se debe realizaar la búsqueda del ID de la publicación previa ( Offering y Request )
		def publication # :doc:
			if params[:request_id]
				id = params[:request_id]
				Request.find(params[:request_id])     
			else
				id = params[:offering_id]
				Offering.find(params[:offering_id])
			end
		end 

		#Método que recibe una publicación y devuelve su URL
		def publication_url(publication) # :doc:
			if Request === publication
				request_path(publication)      
			else
				offering_path(publication)
			end
		end

		#Se valida quiénes son capaces de crear mensajes de manifiesto de interés.
		#
		#Los profesores manifiestan interes en solicitudes de servicio ( Request ).
		#
		#Los socios comunitarios manifiestan interés en ofertas de servicio ( Offering)
		def validate_category_new # :doc:
			if Request === publication
				if current_user.category != 2
					redirect_to root_path, alert: "Solo un profesor puede pedir trabajar en esta solicitud de servicio."
				end
			else
				if current_user.category != 4
					redirect_to root_path, alert: "Solo un socio comunitario puede pedir trabajar en esta oferta de servicio."
				end       
			end
		end

		#Valida que solo un profesor sea capaz de ingresar a ciertas vistas
		def validate_professor # :doc:
			if current_user.category != 2
				redirect_to root_path, alert: "Solo un profesor puede editar este servicio"
			end
		end

		#Valida que el creador de la publicación prubea sea capaz de acceder a ciertas vitas.
		def validate_owner # :doc:
			if current_user == publication.user
				redirect_to root_path, alert: "No puede generar una petición para su propia publicación"
			end			
		end

		#Para la vista de mensajes se separan por estado, en donde.
		#1. Pendiente: mensaje que aun no se ha respondido
		#2. Aceptado: creador de la publicacion acepta trabajar con el que manifestó interés
		#3. Rechazado: creador de la publicación rechaza oferta de trabajar.
		def set_status # :doc:
			@publication = publication
			@services = publication.services.all
			@pendientes = @services.where(status: 1).order("updated_at DESC")
			@aceptados = @services.where(status: 2).order("updated_at DESC")
			@rechazados = @services.where(status: 3).order("updated_at DESC")
		end	

		def set_service
			@service = Service.find(params[:id])
		end

		def service_params
			params.require(:service).permit(
				:publication_id,
				:publication_type,
				:creator_id,
				:acceptor_id,
				:broker_id,
				:institution_id,
				:area_id,
				:description,
				:resume,
				:start_time,
				:end_time,
				:title,
				:message,
				:status,
				:learning_objectives,
				:service_objectives)
		end
end
