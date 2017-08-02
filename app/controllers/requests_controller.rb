class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_category, except: [:index, :show]
  before_action :set_request, only: [:show, :edit, :update]
  
  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Solicitudes", :requests_path
  
  def index
    @disponible = Request.where(status: 1).order("created_at DESC")
    @proceso = Request.where(status: 2).order("created_at DESC")
    @cancelada = Request.where(status: 4).order("created_at DESC")
    @caducada = Request.where(status: 5).order("created_at DESC")
  end

  def show
    add_breadcrumb "Mostrar"
    @comment_request = CommentRequest.new
  end

  def edit
    add_breadcrumb "Editar"
   
    if @request.user_id != current_user.id && current_user.category != 1
      redirect_to root_path, alert: "Usted no es el creador de la solicitud, por lo que no puede modificarla. Contáctese con su administrador."
    end
  end

  def new
    add_breadcrumb "Nueva solicitud"
    @request = Request.new
  end

  def create
    @request = current_user.requests.new(defined_params)
    @request.status = 1
    if @request.save
      flash[:notice] = "La solicitud de servicio ha sido creada correctamente"
      redirect_to :action => 'index'
    else
      flash[:alert] = "Ha ocurrido un error en la creación de la solicitud"
      render :action => 'new'
    end
  end

  def update
    if @request.update_attributes(defined_params)
    flash[:notice] = "La solicitud de servicio ha sido actualizada correctamente"
     redirect_to :action => 'show', :id => @request
    else
     render :action => 'edit'
    end
  end

  def destroy
    Request.find(params[:id]).destroy
    flash[:notice] = "La solicitud de servicio se ha eliminado"
    redirect_to :action => 'index'
  end

  def searchRequest
    add_breadcrumb "Búsqueda"
    @requests = Request.order("created_at DESC").all
    if params[:search]
      @requests = Request.search(params[:search]).order("created_at DESC")
    else
      @requests = Request.order("created_at DESC").all
    end
  end
private
  
  def validate_category
      if current_user.category == 2
          redirect_to root_path, alert: "Su categoría de profesor no permite ésta acción."
      end   
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  def defined_params
    params.require(:request).permit(:id, :title, :description, :user_id, :area_id, :status, :start_time, :end_time,:resume)
  end

end