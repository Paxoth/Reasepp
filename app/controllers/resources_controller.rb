class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_category, except: [:show,:muestra,:searchResource]
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_categorizated, only: [:index, :muestra]

  add_breadcrumb "Inicio", :root_path
  # GET /resources
  # GET /resources.json
  def index
    add_breadcrumb "Administrar", :sections_path
    add_breadcrumb "Recursos", :resources_path 
  end

  def muestra
      add_breadcrumb "Recursos", :resources_muestra_path
      @interest_links = InterestLink.order("created_at DESC").all
  end

  # GET /resources/1
  # GET /resources/1.json
  def show
    add_breadcrumb "Recursos", :resources_muestra_path 
    add_breadcrumb "Detalle"
  end

  # GET /resources/new
  def new
    add_breadcrumb "Administrar", :sections_path
    add_breadcrumb "Recursos", :resources_path 
    add_breadcrumb "Nuevo recurso"
    @resource = Resource.new
  end

  # GET /resources/1/edit
  def edit
    add_breadcrumb "Administrar", :sections_path
    add_breadcrumb "Recursos", :resources_path 
    add_breadcrumb "Editar recurso"
  end

  # POST /resources
  # POST /resources.json
  def create
    @resource = Resource.new(resource_params)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @resource, notice: 'El recurso se ha creado exitosamente.' }
        format.json { render :show, status: :created, location: @resource }
      else
        format.html { render :new }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resources/1
  # PATCH/PUT /resources/1.json
  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @resource, notice: 'El recurso se ha modificado exitosamente' }
        format.json { render :show, status: :ok, location: @resource }
      else
        format.html { render :edit }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.json
  def destroy
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: 'El recurso se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  def searchResource
    add_breadcrumb "Recursos", :resources_muestra_path 
    add_breadcrumb "Búsqueda"
    @resources = Resource.order("created_at DESC").all
    if params[:search]
      @resources = Resource.search(params[:search]).order("created_at DESC")
    else
      @resources = Resource.order("created_at DESC").all
    end
  end

  private

    def validate_category
      if current_user.category != 1
      redirect_to root_path, alert: "Sólo un administrador puede trabajar las actas."
      end   
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    def set_categorizated
      @actas = Resource.where(category: 1).order("date DESC")
      @plantillas = Resource.where(category: 2).order("created_at DESC")
      @formacion = Resource.where(category: 3).order("created_at DESC")
      @enlaces = Resource.where(category: 4).order("name DESC")
      @otros = Resource.where(category: 5).order("created_at DESC")
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:name, :date, :archive,:description, :category)
    end
end
