class InstitutionsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :set_institution, only: [:show, :edit, :update, :destroy]
	before_action :validate_category, except: [:show,:index]
	before_action :set_breadcrumbs


	# GET /institutions
	# GET /institutions.json
	def index
		
		@institutions = Institution.paginate(page: params[:page],per_page: 15).order("name ASC").all
	end

	# GET /institutions/1
	# GET /institutions/1.json
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

	# GET /institutions/new
	def new
		add_breadcrumb "Nueva institucion", institutions_path
		@institution = Institution.new
	end

	# GET /institutions/1/edit
	def edit
		add_breadcrumb "Editar", institutions_path
	end

	# POST /institutions
	# POST /institutions.json
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

	# PATCH/PUT /institutions/1
	# PATCH/PUT /institutions/1.json
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

	# DELETE /institutions/1
	# DELETE /institutions/1.json
	def destroy
		@institution.destroy
		respond_to do |format|
			format.html { redirect_to institutions_url, notice: 'La institución se ha eliminado.' }
			format.json { head :no_content }
		end
	end

	private
		def set_breadcrumbs
			add_breadcrumb "Inicio", :root_path
			if !user_signed_in?
				add_breadcrumb "¿Quiénes somos?", :presentation_somos_path
				
			else
				add_breadcrumb "Instituciones", institutions_path
			end
		end

		def validate_category
			if !@institution.manager_id.blank?
				if current_user.id != @institution.manager_id
					redirect_to root_path, alert: "Sólo un encargado AS puede trabajar sobre esta institución."
				end
			elsif !current_user.is_admin?
				redirect_to root_path, alert: "Solo un admin puede trabajar sobre las insituciones, mientras no haya encargado AS."
			end
		end

		# Use callbacks to share common setup or constraints between actions.
		def set_institution
			@institution = Institution.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def institution_params
			params.require(:institution).permit(
				:name, 
				:web, 
				:logo, 
				:manager_id)
		end
end
