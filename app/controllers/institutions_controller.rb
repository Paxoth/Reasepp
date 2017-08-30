class InstitutionsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :validate_category, except: [:show]
  before_action :set_institution, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Administración", :sections_path

  # GET /institutions
  # GET /institutions.json
  def index
    add_breadcrumb "Instituciones", institutions_path 
    @institutions = Institution.paginate(page: params[:page],per_page: 15).order("name ASC").all
  end

  # GET /institutions/1
  # GET /institutions/1.json
  def show
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

    def validate_category
      if current_user.category != 1
      redirect_to root_path, alert: "Sólo un administrador puede trabajar la página de inicio."
      end   
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_institution
      @institution = Institution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def institution_params
      params.require(:institution).permit(:name, :web, :logo)
    end
end
