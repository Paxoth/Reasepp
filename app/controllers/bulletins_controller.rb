class BulletinsController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_category
  before_action :set_bulletin, only: [:show, :update, :destroy]
  add_breadcrumb "Inicio", :root_path
  add_breadcrumb "Administración", :sections_path
  add_breadcrumb "Boletines", :bulletins_path

  # GET /bulletins
  # GET /bulletins.json
  def index
    @bulletins = Bulletin.all
  end

  # GET /bulletins/1
  # GET /bulletins/1.json
  def show
      add_breadcrumb "Boletin "+@bulletin.title, :root_path
      @sections = Section.where(['created_at >= ? AND module = ?',@bulletin.start_date, "Novedad"])
      @events = Event.where(['created_at >= ?',@bulletin.start_date])
      @offerings = Offering.where(['created_at >= ?',@bulletin.start_date])
      @requests = Request.where(['created_at >= ?',@bulletin.start_date])
  end

  # GET /bulletins/new
  def new
    @bulletin = Bulletin.new
  end

  # POST /bulletins
  # POST /bulletins.json
  def create
    @bulletin = Bulletin.new(bulletin_params)
    @user = User.all

    respond_to do |format|
      if @bulletin.save
        @sections = Section.where(['created_at >= ?',@bulletin.start_date])
        @events = Event.where(['created_at >= ?',@bulletin.start_date])
        @offerings = Offering.where(['created_at >= ?',@bulletin.start_date])
        @requests = Request.where(['created_at >= ?',@bulletin.start_date])
        @user.each do |user|
          BulletinMailer.bulletin(@bulletin,user,@sections,@events,@offerings,@requests).deliver
        end
        format.html { redirect_to @bulletin, notice: 'Bulletin was successfully created.' }
        format.json { render :show, status: :created, location: @bulletin }
      else
        format.html { render :new }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bulletins/1
  # PATCH/PUT /bulletins/1.json
  def update
    respond_to do |format|
      if @bulletin.update(bulletin_params)
        format.html { redirect_to @bulletin, notice: 'Bulletin was successfully updated.' }
        format.json { render :show, status: :ok, location: @bulletin }
      else
        format.html { render :edit }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletins/1
  # DELETE /bulletins/1.json
  def destroy
    @bulletin.destroy
    respond_to do |format|
      format.html { redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def validate_category
      if current_user.category != 1
      redirect_to root_path, alert: "Sólo un administrador puede trabajar la página de inicio."
      end   
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_bulletin
      @bulletin = Bulletin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :start_date)
    end

end
