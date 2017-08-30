class RequestsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, except: [:index, :show, :searchRequest]
	before_action :set_request, only: [:show, :edit, :update]
	before_action :unique_petition, only: [:show]
	
	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Solicitudes", :requests_path

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

	def show
		add_breadcrumb "Mostrar"
		@comment = Comment.new
		@aceptados = @request.services.where("status= 2 or status= 4")
		if @request.end_time < Time.now && @request.status == 1
			@request.update(status: 3)
			flash[:alert] = "La fecha límite de la solicitud ya ha sido sobrepasada. La oferta ha caducado"
		end
	end

	def new
		add_breadcrumb "Nueva solicitud"
		@request = Request.new
	end

	def edit
		add_breadcrumb "Editar"
		if @request.user_id != current_user.id
			redirect_to root_path, alert: "Usted no es el creador de la solicitud, por lo que no puede modificarla. Contáctese con su administrador."
		end
	end

	def create
		@request = current_user.requests.new(defined_params)
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

	def destroy
		Request.find(params[:id]).destroy
		flash[:notice] = "La solicitud de servicio se ha eliminado"
		redirect_to :action => 'index'
	end

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
		def validate_category
			if current_user.category == 2 
				redirect_to root_path, alert: "Su categoría de profesor no permite ésta acción."
			end  
			if current_user.category == 1
			  redirect_to root_path, alert: "El administrador no puede crear solicitudes de servicio"
			end
		end

		# Use callbacks to share common setup or constraints between actions.
		def set_request
			@request = Request.find(params[:id])
		end

		def unique_petition
			@petition = @request.services.where(:creator_id => current_user.id)
		end
		def defined_params
			params.require(:request).permit(:id, 
				:title, 
				:description, 
				:user_id,
				:institution_id, 
				:area_id, 
				:status, 
				:start_time, 
				:end_time,
				:resume,
				:location)
		end
end