=begin rdoc
  _**Areas** controlador de las áreas de trabajo (Ver Area)_
=end
class AreasController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :validate_category, except: [:show, :index]
  before_action :set_area, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Inicio", :root_path
  

  #Vista Principal
  #
  #Genera la consulta de las áreas ordenadas por disciplina y nombre.  
  def index
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    @areas = Area.order("discipline ASC").order("name ASC").all
  end


  #Vista específica
  #
  #Muestra la vista de un área en específico clasificado por ID
  def show
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    add_breadcrumb @area.name
  end

  #Vista Nueva área
  #
  #Pérmite la creación de una nueva área de trabajo
  def new
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    add_breadcrumb "Nueva Area de Trabajo"
    @area = Area.new
  end

  #Vista Editar área
  #
  #Pérmite la edición de un área de trabajo ya generado.
  def edit
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    add_breadcrumb "Editar"
  end

  #Crear área
  #
  #Genera la nueva área con los parametros permitidos de la clase Area y redirecciona la vista de esta.
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'El área de trabajo se ha creado exitosamente.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  #Actualizar área
  #
  #Genera el cambio realizado a través de la vista de editar área con los parametros permitidos de la clase Area y redirecciona la vista de esta.
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to @area, notice: 'El área de trabajo se ha modificado exitosamente' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  #Eliminar área
  #
  #Permite eliminar de la base de datos el área de trabajo
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: 'El área de trabajo se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  private

    #Confirma que el único capaz de entrar a vistas de Area sea un administrador.
    #
    #Excepto a la vista principal y la específica.
    def validate_category # :doc:
      if !current_user.is_admin?
        redirect_to root_path, alert: "Sólo un administrador puede trabajar la página de inicio."
      end   
    end

    #Permite la consulta específica de un área de trabajo
    #Utilizado para la vista específica y la edición de un área.
    def set_area # :doc:
      @area = Area.find(params[:id])
    end

    #Parametros permitidos para creación y edición de un área de trabajo.
    def area_params # :doc:
      params.require(:area).permit(:name, :description, :discipline)
    end
end
