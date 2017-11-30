=begin rdoc
  _**Offering:** controlador de las Ofertas de Servicio (Ver Offering)_
=end
class OfferingsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, except: [:index, :show, :searchOffering]
	before_action :set_offering, only: [:show, :edit, :update, :destroy, :professor]
	before_action :set_area, only: [:edit, :update]
	before_action :unique_petition, only: [:show]
	before_action :set_broker, only: [:show]


	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Actividades AS"
	add_breadcrumb "Ofertas de Servicio", :offerings_path

	#Vista principal
	#
	#Consulta por todas las Ofertas de servicio clasificadas por estados.
	def index
		@disponible = Offering.where(status: 1).order("created_at DESC")
		@cancelada = Offering.where(status: 2).order("created_at DESC")
		@caducada = Offering.where(status: 3).order("created_at DESC")
	end

	#Vista Específica
	#
	#Consulta por los comentarios generados en esta oferta, del mismo modo que permite generar un nuevo comentario.
	#Cambia el estado de la oferta en caso de que su tiempo final sea superado.
	#
	#Los comentarios tienen funciones extras desde sus views (Nombrar profesor responsable)
	def show
		add_breadcrumb "Mostrar"
		@comment = Comment.new
		@aceptados = @offering.services.where("status= 2 or status= 4")
		if @offering.end_time < Time.now && @offering.status == 1
			@offering.update(status: 3)
			flash[:alert] = "La fecha límite de la oferta ya ha sido sobrepasada. La oferta ha caducado"
		end
	end

	#Vista de nueva oferta de servicio
	#
	#Generada automáticamente por scaffold.
	def new
		add_breadcrumb "Nueva oferta"
		@offering = Offering.new
	end

	#Vista de nueva oferta de servicio
	#
	#Redirecciona en caso de que el usuario intenta editar la oferta no sea el creador de la oferta.
	def edit
		add_breadcrumb "Editar"
		if @offering.user_id != current_user.id 
			redirect_to root_path, alert: "Usted no es el creador de la oferta, por lo que no puede modificarla. Contáctese con su administrador."
		end
	end

	#Método que permite crear la Oferta de servicio.
	#
	#Creado desde un usuario, impidiendole crearlo si no es un profesor o un vinculador social.
	#Además se validan las fechas que estén dentro de valores válidos.
	def create
		@offering = current_user.offerings.new(offering_params)
		
		if current_user.category == 3 #El creador es vinculador social
			@offering.broker_id = current_user.id
			flash[:alert] = "Para que esta oferta de servicio se concrete, un profesor debe aceptarla inicialmente."
		end
		@offering.status = 1
		@offering.start_time = Time.now
		respond_to do |format|
			if @offering.save
				if @offering.end_time + 1.minutes < @offering.start_time
					@offering.update(end_time: @offering.start_time) 
					flash[:alert] = "La fecha de término no puede ser menor a la de inicio, esta se ha modificado automáticamente"

				end
				format.html { redirect_to @offering, notice: 'La oferta de servicio ha sido creada correctamente.' }
				format.json { render :show, status: :created, location: @offering }
			else
				format.html { render :new }
				format.json { render json: @offering.errors, status: :unprocessable_entity }
			end
		end
	end

	#Actualizar la oferta de servicio
	#
	#Permite actualizar la oferta de servicio de acuerdo a los parámetros establecidos.
	#Además se preocupa de validar las fechas de manera correcta.
	def update
		respond_to do |format|
			if @offering.update(offering_params)
				if @offering.start_time < @offering.created_at - 1.days 
					@offering.update(start_time: Time.now) 
					flash[:alert] = "La fecha de inicio no puede ser menor a la de hoy, esta se ha modificado automáticamente"
				end
				if @offering.end_time + 1.minutes < @offering.start_time
					@offering.update(end_time: @offering.start_time) 
					flash[:alert] = "La fecha de término no puede ser menor a la de inicio, esta se ha modificado automáticamente"

				end
				format.html { redirect_to @offering, notice: 'La oferta de servicio ha sido actualizada correctamente.' }
				format.json { render :show, status: :ok, location: @offering }
			else
				format.html { render :edit }
				format.json { render json: @offering.errors, status: :unprocessable_entity }
			end
		end
	end

	# No utilizado comunmente, puesto que la oferta se le cambia el estado a cancelado.
	# Generado automáticamente con scaffold.
	def destroy # :nodoc:
		@offering.destroy
		respond_to do |format|
			format.html { redirect_to offerings_url, notice: 'Se ha eliminado la oferta de servicio.' }
			format.json { head :no_content }
		end
	end

	#Vista que permite generar una consulta a través de la función search de Offering utilizando los parámetros de un input.
	def searchOffering
		add_breadcrumb "Búsqueda"
		@offerings = Offering.order("created_at DESC").all
		if params[:search]
			@offerings = Offering.search(params[:search]).order("created_at DESC")
		else
			@offerings = Offering.order("created_at DESC").all
		end
	
	end

	private
		#Redirecciona a los socios comunitarios a la página inicial para que no puedan realizara acciones solo permitidas por los profesores  y vinculadores sociales.
		def validate_category # :doc
			if current_user.category == 4 
				redirect_to root_path, alert: "Su categoría de socio comunitario no permite ésta acción."
			end  
		end

		def set_offering
			@offering = Offering.find(params[:id])
		end

		#Se realiza las consultas de áreas de trabajo para poder asignarselas a las ofertas ( Area)
		def set_area # :doc:
			@areas = Area.order("discipline ASC").order("name ASC").all     
		end

		#Consulta del servicio específico que haya sido aceptado por el profesor.
		def unique_petition # :doc:
			@petition = @offering.services.where(:creator_id => current_user.id)
		end

		#Consulta que busca al usuario vinculador social en caso de ser el creador de la Oferta de servicio.
		def set_broker # :doc:
			if @offering.broker_id.present?
				@broker = User.where(id: @offering.broker_id).first
			end
		end
		
		def offering_params
			params.require(:offering).permit(
				:user_id, 
				:area_id,
				:broker_id,
				:institution_id, 
				:title, 
				:description, 
				:status, 
				:start_time, 
				:end_time, 
				:resume,
				:location)
		end
end
