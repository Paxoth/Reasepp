=begin rdoc
  _**Event:** controlador de los Eventos (Ver Event)_
=end
class EventsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :listado, :show]
	before_action :validate_category, except: [:index, :show, :listado,:searchEvent]
	before_action :set_event, only: [:show, :edit, :update, :destroy]

	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Eventos", :events_path

	#Vista Principal
	#
	#Genera la consulta de todos los eventos activos, ordenados por fecha de inicio.
	#
	#Vista en forma de calendario.
	def index
		@events = Event.order("start_time ASC").where(status: 1)
	end

	#Vista listado
	#
	#Genera la consulta de todos los eventos en sus diferentes estados.
	def listado
		@disponibles = Event.where(status: 1).paginate(page: params[:disponibles],per_page: 5).order("start_time ASC")
		@realizados = Event.where(status: 2).order("updated_at ASC")
		@cancelados = Event.where(status: 3).order("updated_at ASC")
		@caducados = Event.where(status: 4).order("start_time ASC")
	end

	#Vista para buscar eventos a través de la consulta de una palabra.
	def searchEvent
		add_breadcrumb "Búsqueda"
		@events = Event.order("start_time ASC").all
		if params[:search]
			@events = Event.search(params[:search]).order("start_time ASC")
		else
			@events = Event.order("start_time ASC").all
		end
	end
	
	#Vista específica
	#
	#Muestra un evento con toda su información. En caso de que la fecha del evento haya pasado, indica que el evento caducó.
	def show
		add_breadcrumb "Mostrar"
		@comment = Comment.new
		if @event.end_time < Time.now && @event.status == 1
			@event.update(status: 4)
      		flash[:alert] = "La fecha límite del evento ya ha sido sobrepasada, por lo cual ha caducado."
		end
	end

	# Nuevo evento
	#
	# Vista que permite la creación de un nuevo evento.
	def new
		add_breadcrumb "Nuevo evento"
		@event = Event.new
	end

	# Editar evento
	#
	# Vista que permite la edición de un evento que es capturado por su ID.
	def edit
		add_breadcrumb "Editar"
	end

	# Crear Evento
	# Método que permite la cración de un evento bajo el nombre de un usuario coenctado.
	# Valida que la fecha de inicio no sea mayor que la de término.
	def create
		@event = current_user.events.new(event_params)
		@event.status = 1

		respond_to do |format|
			if @event.save
				if @event.start_time < @event.created_at - 30.minutes 
					@event.update(start_time: Time.now) 
					flash[:alert] = "La fecha de inicio no puede ser menor a la de hoy, esta se ha modificado automáticamente"
				end
				if @event.end_time + 1.minutes < @event.start_time
					@event.update(end_time: @event.start_time) 
					flash[:alert] = "La fecha de término no puede ser menor a la de inicio, esta se ha modificado automáticamente"

				end
				format.html { redirect_to @event, notice: 'El evento se ha creado exitosamente.' }
				format.json { render :show, status: :created, location: @event }
			else
				format.html { render :new }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	# Actualizar evento
	#
	# Método que permite actualizar los datos del evento. Valida las fechas.
	def update
		respond_to do |format|
			if @event.update(event_params)
				if @event.start_time < @event.created_at - 30.minutes
					@event.update(start_time: Time.now) 
					flash[:alert] = "La fecha de inicio no puede ser menor a la de hoy, esta se ha modificado automáticamente"
				end
				if @event.end_time + 1.minutes < @event.start_time
					@event.update(end_time: @event.start_time) 
					flash[:alert] = "La fecha de término no puede ser menor a la de inicio, esta se ha modificado automáticamente"

				end
				format.html { redirect_to @event, notice: 'El evento se ha modificado exitosamente.' }
				format.json { render :show, status: :ok, location: @event }
			else
				format.html { render :edit }
				format.json { render json: @event.errors, status: :unprocessable_entity }
			end
		end
	end

	# Eliminar evento, generado automáticamente por scaffold
	def destroy
		@event.destroy
		respond_to do |format|
			format.html { redirect_to events_url, notice: 'El evento se ha eliminado.' }
			format.json { head :no_content }
		end
	end

	private
		#Valida que los usuarios que puedan generar eventos sean administradores.
		def validate_category # :doc:
			if !current_user.is_admin?
				redirect_to root_path, alert: "Sólo un administrador puede trabajar los eventos."
			end 
		end

		
		def set_event
			@event = Event.find(params[:id])
		end

		def event_params
			params.require(:event).permit(
				:user_id, 
				:title, 
				:description, 
				:address, 
				:start_time, 
				:end_time, 
				:status)
		end

end
