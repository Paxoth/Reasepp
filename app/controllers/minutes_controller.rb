class MinutesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :validate_category, except: [:show]
  before_action :set_minute, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Administrar", :sections_path
  add_breadcrumb "Actas de reunión", :minutes_path 

  # GET /minutes
  # GET /minutes.json
  def index
    @minutes = Minute.order("created_at DESC").all
  end

  # GET /minutes/1
  # GET /minutes/1.json
  def show
    add_breadcrumb "Detalle" 
  end

  # GET /minutes/new
  def new
    add_breadcrumb "Nueva acta"
    @minute = Minute.new
  end

  # GET /minutes/1/edit
  def edit
    add_breadcrumb "Editar acta"
  end

  # POST /minutes
  # POST /minutes.json
  def create
    @minute = Minute.new(minute_params)

    respond_to do |format|
      if @minute.save
        format.html { redirect_to @minute, notice: 'El acta se ha creado exitosamente.' }
        format.json { render :show, status: :created, location: @minute }
      else
        format.html { render :new }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /minutes/1
  # PATCH/PUT /minutes/1.json
  def update
    respond_to do |format|
      if @minute.update(minute_params)
        format.html { redirect_to @minute, notice: 'El acta se ha modificado exitosamente' }
        format.json { render :show, status: :ok, location: @minute }
      else
        format.html { render :edit }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /minutes/1
  # DELETE /minutes/1.json
  def destroy
    @minute.destroy
    respond_to do |format|
      format.html { redirect_to minutes_url, notice: 'El acta se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  private

    def validate_category
      if current_user.category != 1
      redirect_to root_path, alert: "Sólo un administrador puede trabajar las actas."
      end   
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_minute
      @minute = Minute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def minute_params
      params.require(:minute).permit(:name, :date, :archive)
    end
end
