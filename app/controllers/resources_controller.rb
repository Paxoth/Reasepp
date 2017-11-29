=begin rdoc
  _**Resource:** controlador de los recursos descargables (Ver Resource)_

  _Los recursos son creados generalmente por administradores o usuarios específicos_

  _La mayoría de los métodos fueron generados automáticamente por scaffold y no fueron modificados, por lo que no se documentan_
=end
class ResourcesController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_category, except: [:show,:muestra,:searchResource]
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :set_categorizated, only: [:index, :muestra]

  add_breadcrumb "Inicio", :root_path

  #Vista principal
  #
  #Utilizada para los adminstradores puedan operar los recursos existentes y crear nuevos.
  def index 
    add_breadcrumb "Administrar", :sections_path
    add_breadcrumb "Recursos", :resources_path 
  end

  #Vista de muestra
  #
  #Vista para los usuarios no adminsitradores, en donde podrán descargar los recursos disponibles.
  def muestra
      add_breadcrumb "Recursos", :resources_muestra_path
      @interest_links = InterestLink.order("created_at DESC").all
  end

  def show # :nodoc:
    add_breadcrumb "Recursos", :resources_muestra_path 
    add_breadcrumb "Detalle"
  end

  def new # :nodoc:
    add_breadcrumb "Administrar", :sections_path
    add_breadcrumb "Recursos", :resources_path 
    add_breadcrumb "Nuevo recurso"
    @resource = Resource.new
  end

  def edit # :nodoc:
    add_breadcrumb "Administrar", :sections_path
    add_breadcrumb "Recursos", :resources_path 
    add_breadcrumb "Editar recurso"
  end

  def create # :nodoc:
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

  def update # :nodoc:
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

  def destroy # :nodoc:
    @resource.destroy
    respond_to do |format|
      format.html { redirect_to resources_url, notice: 'El recurso se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  #Vista de búsqueda de recursos
  #
  #Vista que utiliza los métodos search para hacer búsqueda de recursos a través de palabras (Ver Resource)
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

    #Validar que solo un administrador peuda acceder a ciertas vistas de recursos descargables.
    def validate_category # :doc:
      if !current_user.is_admin?
      redirect_to root_path, alert: "Sólo un administrador puede trabajar las actas."
      end   
    end

    def set_resource
      @resource = Resource.find(params[:id])
    end

    #Hace llamadas a diferentes consultas de acuerdo a la categoría de ellos.
    #Esto con el fin de hacer las consultas necesarias en las diferentes ventanas de las vistas de recursos.
    def set_categorizated # :doc:
      @actas = Resource.where(category: 1).order("date DESC")
      @plantillas = Resource.where(category: 2).order("created_at DESC")
      @formacion = Resource.where(category: 3).order("created_at DESC")
      @enlaces = Resource.where(category: 4).order("name DESC")
      @otros = Resource.where(category: 5).order("created_at DESC")
    end
    
    def resource_params
      params.require(:resource).permit(:name, :date, :archive,:description, :category)
    end
end
