class OfferingsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, except: [:index, :show, :searchOffering]
	before_action :set_offering, only: [:show, :edit, :update, :destroy]
	before_action :set_area, only: [:edit, :update]
	before_action :unique_petition, only: [:show]

	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Ofertas", :offerings_path

	# GET /offerings
	# GET /offerings.json
	def index
		@disponible = Offering.where(status: 1).paginate(page: params[:page],per_page: 5).order("created_at DESC")
		@cancelada = Offering.where(status: 2).order("created_at DESC")
		@caducada = Offering.where(status: 3).order("created_at DESC")
	end

	# GET /offerings/1
	# GET /offerings/1.json
	def show
		add_breadcrumb "Mostrar"
		@comment = Comment.new
		@aceptados = @offering.services.where("status= 2 or status= 4")
		if @offering.end_time < Time.now && @offering.status == 1
			@offering.update(status: 3)
			flash[:alert] = "La fecha límite de la oferta ya ha sido sobrepasada. La oferta ha caducado"
		end
	end


	# GET /offerings/new
	def new
		add_breadcrumb "Nueva oferta"
		@offering = Offering.new
	end

	# GET /offerings/1/edit
	def edit
		add_breadcrumb "Editar"
		if @offering.user_id != current_user.id 
			redirect_to root_path, alert: "Usted no es el creador de la oferta, por lo que no puede modificarla. Contáctese con su administrador."
		end
	end

	# POST /offerings
	# POST /offerings.json
	def create
		@offering = current_user.offerings.new(offering_params)
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

	# PATCH/PUT /offerings/1
	# PATCH/PUT /offerings/1.json
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

	# DELETE /offerings/1
	# DELETE /offerings/1.json
	def destroy
		@offering.destroy
		respond_to do |format|
			format.html { redirect_to offerings_url, notice: 'Se ha eliminado la oferta de servicio.' }
			format.json { head :no_content }
		end
	end

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
		def validate_category
			if current_user.category == 4
				redirect_to root_path, alert: "Su categoría de socio comunitario no permite ésta acción."
			end 
			if current_user.category == 1
			  redirect_to root_path, alert: "El administrador no puede crear ofertas de servicio"
			end
		end

		# Use callbacks to share common setup or constraints between actions.
		def set_offering
			@offering = Offering.find(params[:id])
		end

		def set_area
			@areas = Area.order("discipline ASC").order("name ASC").all     
		end

		def unique_petition
			@petition = @offering.services.where(:creator_id => current_user.id)
		end
		# Never trust parameters from the scary internet, only allow the white list through.
		def offering_params
			params.require(:offering).permit(
				:user_id, 
				:area_id,
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
