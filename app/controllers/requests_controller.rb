=begin rdoc
  _**Request:** controlador de las Solicitudes de Servicio (Ver Request)_
=end
class RequestsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, except: [:index, :show, :searchRequest]
	before_action :set_request, only: [:show, :edit, :update]
	before_action :unique_petition, only: [:show]
	before_action :set_broker, only: [:show]

	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Actividades AS"
	add_breadcrumb "Solicitudes de Servicio", :requests_path
	
	#Vista principal
	#
	#Consulta por todas las solicitud de servicio clasificadas por estados.
	def index
		@disponible = Request.where(status: 1).paginate(page: params[:page],per_page: 5).order("created_at DESC")
		@cancelada = Request.where(status: 2).order("created_at DESC")
		@caducada = Request.where(status: 3).order("created_at DESC")
		if params[:search]
			@offerings = Request.search(params[:search]).order("created_at DESC")
		else
			@offerings = Request.order("created_at DESC").all
		end
	end

	#Vista Específica
	#
	#Consulta por los comentarios generados en esta solicitud, del mismo modo que permite generar un nuevo comentario.
	#Cambia el estado de la solicitud en caso de que su tiempo final sea superado.
	#
	#Los comentarios tienen funciones extras desde sus views (Nombrar profesor responsable)
	def show
		add_breadcrumb "Mostrar"
		@comment = Comment.new
		@aceptados = @request.services.where("status= 2 or status= 4")
		if @request.end_time < Time.now && @request.status == 1
			@request.update(status: 3)
			flash[:alert] = "La fecha límite de la solicitud ya ha sido sobrepasada. La solicitud ha caducado"
		end
	end

	#Vista de nueva solicitud de servicio
	#
	#Generada automáticamente por scaffold.
	def new
		add_breadcrumb "Nueva solicitud"
		@request = Request.new
	end

	#Vista de nueva solicitud de servicio
	#
	#Redirecciona en caso de que el usuario intenta editar la solicitud no sea el creador de esta.
	def edit
		add_breadcrumb "Editar"
		if @request.user_id != current_user.id
			redirect_to root_path, alert: "Usted no es el creador de la solicitud, por lo que no puede modificarla. Contáctese con su administrador."
		end
	end

	#Método que permite crear la solicitud de servicio.
	#
	#Creado desde un usuario, impidiendole crearlo si no es un socio comunitario o un vinculador social.
	#Además se validan las fechas que estén dentro de valores válidos.
	def create
		@request = current_user.requests.new(defined_params)
		if current_user.category == 3 #El creador es vinculador social
			@request.broker_id = current_user.id
			flash[:alert] = "Para que esta solicitud de servicio se concrete, un socio comunitario debe aceptarla inicialmente."
		end
		@request.status = 1
		@request.start_time = Time.now
		if @request.save
			if @request.end_time + 1.minutes < @request.start_time
				@request.update(end_time: @request.start_time) 
				flash[:alert] = "La fecha de término no puede ser menor a la de inicio, esta se ha modificado automáticamente"
			end
			flash[:notice] = "La solicitud de servicio ha sido creada correctamente"
			redirect_to :action => 'index'
		else
			flash[:alert] = "Ha ocurrido un error en la creación de la solicitud"
			render :action => 'new'
		end
	end

	#Actualizar la solicitud de servicio
	#
	#Permite actualizar la solicitud de servicio de acuerdo a los parámetros establecidos.
	#Además se preocupa de validar las fechas de manera correcta.
	def update
		if @request.update_attributes(defined_params)
			if @request.start_time < @request.created_at - 1.days
				@request.update(start_time: Time.now) 
				flash[:alert] = "La fecha de inicio no puede ser menor a la de hoy, esta se ha modificado automáticamente"
			end
			if @request.end_time + 1.minutes < @request.start_time
				@request.update(end_time: @request.start_time) 
				flash[:alert] = "La fecha de término no puede ser menor a la de inicio, esta se ha modificado automáticamente"
			end
			flash[:notice] = "La solicitud de servicio ha sido actualizada correctamente"
			redirect_to :action => 'show', :id => @request
		else
			render :action => 'edit'
		end
	end

	#No utilizado, generalmente las ofertas se cancelan, no se eliminan.
	def destroy #:nodoc:
		Request.find(params[:id]).destroy
		flash[:notice] = "La solicitud de servicio se ha eliminado"
		redirect_to :action => 'index'
	end
	
	#Vista que permite generar una consulta a través de la función search de Request utilizando los parámetros de un input.
	def searchRequest
		add_breadcrumb "Búsqueda"
		@requests = Request.order("created_at DESC").all
		if params[:search]
			@requests = Request.search(params[:search]).order("created_at DESC")
		else
			@requests = Request.order("created_at DESC").all
		end
	end

	private
		#Redirecciona a los profesores a la página inicial para que no puedan realizara acciones solo permitidas por los socios y vinculadores sociales.
		def validate_category # :doc:
			if current_user.category == 2 
				redirect_to root_path, alert: "Su categoría de profesor no permite ésta acción."
			end  
		end

		def set_request
			@request = Request.find(params[:id])
		end

		#Consulta que busca al usuario vinculador social en caso de ser el creador de la Solicitud de servicio.
		def set_broker # :doc:
			if @request.broker_id.present?
				@broker = User.where(id: @request.broker_id).first
			end
		end

		#Consulta del servicio específico que haya sido aceptado por el socio comunitario.
		def unique_petition # :doc:
			@petition = @request.services.where(:creator_id => current_user.id)
		end
		def defined_params
			params.require(:request).permit(:id, 
				:title, 
				:description, 
				:user_id,
				:broker_id,
				:institution_id, 
				:area_id, 
				:status, 
				:start_time, 
				:end_time,
				:resume,
				:location)
		end
end