class InterestLinksController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :validate_category, except: [:show]
  before_action :set_interest_link, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Administrar", :sections_path
  add_breadcrumb "Link de interés", :interest_links_path 

  # GET /interest_links
  # GET /interest_links.json
  def index
    @interest_links = InterestLink.order("created_at DESC").all
  end

  # GET /interest_links/1
  # GET /interest_links/1.json
  def show
    add_breadcrumb "Mostrar link"
  end

  # GET /interest_links/new
  def new
    add_breadcrumb "Nuevo link"
    @interest_link = InterestLink.new
  end

  # GET /interest_links/1/edit
  def edit
    add_breadcrumb "Editar link"
  end

  # POST /interest_links
  # POST /interest_links.json
  def create
    @interest_link = InterestLink.new(interest_link_params)

    respond_to do |format|
      if @interest_link.save
        format.html { redirect_to @interest_link, notice: 'El link de interés se ha agregado exitosamente.' }
        format.json { render :show, status: :created, location: @interest_link }
      else
        format.html { render :new }
        format.json { render json: @interest_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interest_links/1
  # PATCH/PUT /interest_links/1.json
  def update
    respond_to do |format|
      if @interest_link.update(interest_link_params)
        format.html { redirect_to @interest_link, notice: 'El link de interés se ha actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @interest_link }
      else
        format.html { render :edit }
        format.json { render json: @interest_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interest_links/1
  # DELETE /interest_links/1.json
  def destroy
    @interest_link.destroy
    respond_to do |format|
      format.html { redirect_to interest_links_url, notice: 'El link de interés se ha eliminado exitosamente.' }
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
    def set_interest_link
      @interest_link = InterestLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_link_params
      params.require(:interest_link).permit(:name, :url, :description)
    end
end
