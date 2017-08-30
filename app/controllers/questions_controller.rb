class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :searchQuestion]
  before_action :validate_category, except: [:show,:searchQuestion]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Administrar", :sections_path
  add_breadcrumb "Preguntas frecuentes", :questions_path

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    add_breadcrumb "Mostrar"
  end

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

  # GET /questions/new
  def new
    add_breadcrumb "Nuevo"
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    add_breadcrumb "Editar"
  end

  # POST /questions
  # POST /questions.json
  def create
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

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
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

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Se ha eliminado la pregunta.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :answer, :reader)
    end

    def validate_category
      if current_user.category != 1
      redirect_to root_path, alert: "Sólo un administrador puede trabajar las preguntas frecuentes."
      end   
    end
end
