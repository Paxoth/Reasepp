=begin rdoc
  _**Project:** controlador de las experiencias documentadas (Ver Project)_
=end
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_category, except: [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Experiencias", :experiences_path
  add_breadcrumb "Experiencias reportadas", :projects_path

  #Vista principal
  #
  #Genera la consulta de las experiencias documentadas paginadas de a 30 elementos.
  def index
    @projects = Project.paginate(page: params[:page],per_page: 30).all.order("created_at DESC")
  end

  #Vista específica
  #
  #Permite la visualización de la experiencia documentada, además de la formación de su pdf ( ProjectPdf )
  def show
    add_breadcrumb "Mostrar"
    respond_to do |format|
      format.html
      format.pdf  do
        pdf = ProjectPdf.new(@project)
        send_data pdf.render, :filename => "Experiencia_#{@project.id}.pdf", 
                  :type => 'application/pdf',
                  :disposition => 'inline'
                  
      end
    end
  end

  #Vista de nueva experiencia documentada.
  #Generada automáticamente con scaffold.
  def new # :nodoc:
    add_breadcrumb "Nueva experiencia reportada"
    @project = Project.new
  end

  #Vista de editar experiencia documentada.
  #Generada automáticamente con scaffold.
  def edit # :nodoc:
    add_breadcrumb "Editar"
  end

  #Vista de crear experiencia documentada.
  #
  #La experiencia documentada quedará bajo el nombre del profesor que la creó.
  def create
    @project = current_user.projects.new(project_params)
    @project.professor_name = current_user.name
    @project.professor_email = current_user.email
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'La experiencia se ha creado exitosamente. ' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  #Vista de actualizar experiencia documentada.
  #Generada automáticamente con scaffold.
  def update # :nodoc:
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'La experiencia se ha modificado exitosamente.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  #Vista de eliminar experiencia documentada.
  #Generada automáticamente con scaffold.
  def destroy # :nodoc:
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'La experiencia se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  private

    def set_project
      @project = Project.find(params[:id])
    end

    #Valida que solo un profesor sea capaz de generar, crear y editar experiencias documentadas.
    def validate_category # :doc:
      if current_user.category != 2
        redirect_to root_path, alert: "Sólo un profesor puede trabajar las experiencias."
      end   
    end

    def project_params
      params.require(:project).permit(
        :title, 
        :description, 
        :faculty, 
        :department, 
        :course_name, 
        :course_type, 
        :course_type_other, 
        :professor_phone,
        :learning_objectives, 
        :service_objectives, 
        :frequency, 
        :weekly_hours, 
        :students_level, 
        :community_partner, 
        :organization_type, 
        :benefited, :results, 
        :tools, 
        :reflection_moments, 
        :period, 
        :professor_degree, 
        :participants,  
        :area_id, 
        :user_id, 
        :institution_id, 
        :start_time, 
        :end_time, 
        :partner)
    end
end
