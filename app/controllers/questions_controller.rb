=begin rdoc
  _**Question:** controlador de las preguntas frecuentes (Ver Question)._

  _Las preguntas frecuentes son visualizadas por cualquier usuario, incluyendo aquellos que no están conectados, pero solamente pueden ser administradas por usuarios administradores._
  
  _La mayoría de los métodos son generados automáticametne por scaffold y no poseen cambio alguno_
=end
class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :searchQuestion]
  before_action :validate_category, except: [:show,:searchQuestion]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Administrar", :sections_path
  add_breadcrumb "Preguntas frecuentes", :questions_path


  def index # :nodoc:
    @questions = Question.all
  end

  def show # :nodoc:
    add_breadcrumb "Mostrar"
  end

  #Vista de búsqueda de preguntas frecuentes
  #
  #Vista que permite utilizar los métodos de search para realizar búsqueda por palabras
  def searchQuestion
    add_breadcrumb "Búsqueda"
    @questions = Question.order("created_at DESC").all
    if params[:search]
      if user_signed_in?
        @questions = Question.search(params[:search]).order("created_at DESC")
      else
        @questions = Question.where(reader: 2).search(params[:search]).order("created_at DESC")
      end
    else
      @questions = Question.order("created_at DESC").all
    end
  end

  def new # :nodoc:
    add_breadcrumb "Nuevo"
    @question = Question.new
  end

  def edit # :nodoc:
    add_breadcrumb "Editar"
  end

  def create # :nodoc:
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'La pregunta ha sido agregada' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update # :nodoc:
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Se ha modificado la pregunta.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy # :nodoc:
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Se ha eliminado la pregunta.' }
      format.json { head :no_content }
    end
  end

  private

    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:title, :answer, :reader)
    end

    #Se valida que solo un usuario sea el capaz de acceder a ciertas vistas de preguntas frecuentes.
    def validate_category # :doc:
      if !current_user.is_admin?
        redirect_to root_path, alert: "Sólo un administrador puede trabajar las preguntas frecuentes."
      end   
    end
end
