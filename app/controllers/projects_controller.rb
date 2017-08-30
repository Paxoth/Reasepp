class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_category, except: [:show, :index]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Experiencias", :experiences_path
  add_breadcrumb "Experiencias reportadas", :projects_path

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.paginate(page: params[:page],per_page: 5).all.order("created_at DESC")
  end

  # GET /projects/1
  # GET /projects/1.json
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

  # GET /projects/new
  def new
    add_breadcrumb "Nueva experiencia reportada"
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    add_breadcrumb "Editar"
  end

  # POST /projects
  # POST /projects.json
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

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
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

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'La experiencia se ha eliminado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def validate_category
      if current_user.category != 2
        redirect_to root_path, alert: "Sólo un profesor puede trabajar las experiencias."
      end   
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(
        :title, 
        :description, 
        :faculty, 
        :department, 
        :course_name, 
        :course_type, 
        :course_type_other, 
        :professor_name, 
        :professor_phone, 
        :professor_email, 
        :learning_objectives, 
        :service_objectives, 
        :frequency, 
        :weekly_hours, 
        :students_level, 
        :community_partner, 
        :organization_type, 
        :benefit, :results, 
        :tools, 
        :reflection_moments, 
        :period, 
        :professor_degree, 
        :participants, 
        :institutional_support, 
        :area_id, 
        :user_id, 
        :institution_id, 
        :start_time, 
        :end_time, 
        :partner)
    end
end
