=begin rdoc
  _**Interest Link:** controlador de los enlaces de interés (Ver InterestLink)_

  _Los métodos de los links de interés son los básicos generados por scaffold_

  _La consulta a los link de interés se genera en ApplicationController, porque su información se puede visualizar desde cualquier vista._
=end
class InterestLinksController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :validate_category, except: [:show]
  before_action :set_interest_link, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Administrar", :sections_path
  add_breadcrumb "Enlaces de interés", :interest_links_path 

  def index # :nodoc:
    @interest_links = InterestLink.order("created_at DESC").all
  end

  def show # :nodoc:
    add_breadcrumb "Mostrar enlace"
  end

  def new # :nodoc:
    add_breadcrumb "Nuevo enlace"
    @interest_link = InterestLink.new
  end

  def edit # :nodoc:
    add_breadcrumb "Editar enlace"
  end

  def create # :nodoc:
    @interest_link = InterestLink.new(interest_link_params)

    respond_to do |format|
      if @interest_link.save
        format.html { redirect_to @interest_link, notice: 'El enlace de interés se ha agregado exitosamente.' }
        format.json { render :show, status: :created, location: @interest_link }
      else
        format.html { render :new }
        format.json { render json: @interest_link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update # :nodoc:
    respond_to do |format|
      if @interest_link.update(interest_link_params)
        format.html { redirect_to @interest_link, notice: 'El enlace de interés se ha actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @interest_link }
      else
        format.html { render :edit }
        format.json { render json: @interest_link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy # :nodoc:
    @interest_link.destroy
    respond_to do |format|
      format.html { redirect_to interest_links_url, notice: 'El enlace de interés se ha eliminado exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    #Valida que solo un administrador sea capaz de ver estas vistas"
    def validate_category # :doc:
      if !current_user.is_admin?
      redirect_to root_path, alert: "Sólo un administrador puede trabajar las actas."
      end   
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_interest_link
      @interest_link = InterestLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_link_params
      params.require(:interest_link).permit(:name, :url, :description)
    end
end
