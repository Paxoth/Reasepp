class AreasController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :validate_category, except: [:show]
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  

  # GET /areas
  # GET /areas.json
  
  def index
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    @areas = Area.order("discipline ASC").order("name ASC").all
  end


  # GET /areas/1
  # GET /areas/1.json
  def show
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    add_breadcrumb @area.name
  end

  # GET /areas/new
  def new
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    add_breadcrumb "Nueva Area de Trabajo"
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
    add_breadcrumb "Experiencias", experiences_path
    add_breadcrumb "Areas de Trabajo", areas_path 
    add_breadcrumb "Editar"
  end

  # POST /areas
  # POST /areas.json
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

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
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

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: 'El área de trabajo se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  private

    def validate_category
      if !current_user.is_admin?
      redirect_to root_path, alert: "Sólo un administrador puede trabajar la página de inicio."
      end   
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:name, :description, :discipline)
    end
end
