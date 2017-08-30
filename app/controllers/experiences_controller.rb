class ExperiencesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_realizado
	before_action :set_experience, only: [:update, :destroy]
	before_action :set_institutionsAndAreas
	before_action :validate_category, except: [:show, :index, :searchExperience]


	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Experiencias", :experiences_path

	def index
		@experiences =Experience.paginate(page: params[:page],per_page: 5).all.order("created_at DESC")
	end

	def new
		@service = servicio
		@experience = @service.experiences.new
	end
	# GET /experiences/1/edit
	def edit
		add_breadcrumb "Editar"
	    @service = servicio
	    @experience = servicio.experiences.find(params[:id])
	    if current_user != @experience.professor
	    	redirect_to root_path, alert: "Solo el profesor dueño de esta experiencia puede editarla."
	    end
	end

	def show
		@experience = Experience.find(params[:id])
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

	# POST /experiences
	# POST /experiences.json
	def create
		@service = servicio
		@experience = @service.experiences.new(experience_params)
		@experience.professor = current_user
		@experience.professor_name = current_user.name
		@experience.professor_email = current_user.email
		if @service.publication_type == "Offering"
			@experience.partner = @service.creator
		else
			@experience.partner = @service.acceptor
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

	# PATCH/PUT /experiences/1
	# PATCH/PUT /experiences/1.json
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

	# DELETE /experiences/1
	# DELETE /experiences/1.json
	def destroy
		@experience.destroy
		respond_to do |format|
			format.html { redirect_to servicio_url(servicio), notice: 'La experiencia se ha eliminado.' }
			format.json { head :no_content }
		end
	end

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

    def servicio
        id = params[:service_id]
        Service.find(params[:service_id])     
    end 

	def validate_category
		if current_user.category != 2
			redirect_to root_path, alert: "Sólo un profesor puede trabajar las experiencias."
		end   
	end

	def set_realizado
		@offerings = Offering.where("status = ?", 3)
		@requests = Request.where("status = ?", 3)
	end

	def set_experience
		@experience = Experience.find(params[:id])
    end

    def set_institutionsAndAreas
    	@institutions = Institution.all
    	@areas = Area.order("discipline ASC").order("name ASC").all	
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(
      		:area_id,
      		:service_id,
			:description,
			:partner_id,
			:professor_id,
			:folio,
			:institution_id,
			:faculty,
			:department,
			:course_name,
			:course_type,
			:course_type_other,
			:period,
			:professor_name,
			:professor_email,
			:professor_phone,
			:professor_degree,
			:learning_objectives,
			:service_objectives,
			:institutional_support,
			:frequency,
			:weekly_hours,
			:participants,
			:students_level,
			:community_partner,
			:organization_type,
			:benefit,
			:results,
			:tools,
			:reflection_moments,
			:title)
    end
end
