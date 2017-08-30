class BulletinsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, except: [:show]
	before_action :set_bulletin, only: [:show, :update, :destroy]
	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Administración", :sections_path, except:[:show]
	add_breadcrumb "Boletines", :bulletins_path, except:[:show]

	# GET /bulletins
	# GET /bulletins.json
	def index
		@bulletins = Bulletin.paginate(page: params[:page],per_page: 5).all
	end

	# GET /bulletins/1
	# GET /bulletins/1.json
	def show
		if current_user.category == 1
			add_breadcrumb "Administración", :sections_path, except:[:show]
			add_breadcrumb "Boletines", :bulletins_path, except:[:show]
		end
		add_breadcrumb "Boletin "+@bulletin.title, :bulletins_path
		@sections = Section.where(['created_at >= ? AND module = ?',@bulletin.start_date, "Novedad"])
		@events = Event.where(['created_at >= ? AND status = ?',@bulletin.start_date,1])
		@offerings = Offering.where(['created_at >= ? AND status = ?',@bulletin.start_date,1])
		@requests = Request.where(['created_at >= ? AND status = ?',@bulletin.start_date,1])
		@services = Service.where(['created_at >= ? AND status = ?',@bulletin.start_date,2])
		@experiences = Experience.where(['created_at >= ?',@bulletin.start_date])
	end

	# GET /bulletins/new
	def new
		@bulletin = Bulletin.new
	end

	# POST /bulletins
	# POST /bulletins.json
	def create
		@bulletin = Bulletin.new(bulletin_params)
		respond_to do |format|
			if @bulletin.save
				if @bulletin.receiver == 1
					@user = User.where(autorization_level: 1)
				elsif @bulletin.receiver == 2
					@user = User.where(autorization_level: 2)
				else
					@user = User.all
				end
				if @bulletin.start_date > @bulletin.created_at
					@bulletin.update(start_date: Time.now) 
					flash[:alert] = "La fecha no puede ser mayor a la de hoy, por lo que se asignó la actual automáticamente"
				end
				@sections = Section.where(['created_at >= ? AND module = ?',@bulletin.start_date, "Novedad"])
				@events = Event.where(['created_at >= ? AND status = ?',@bulletin.start_date,1])
				@offerings = Offering.where(['created_at >= ? AND status = ?',@bulletin.start_date,1])
				@requests = Request.where(['created_at >= ? AND status = ?',@bulletin.start_date,1])
				@services = Service.where(['created_at >= ? AND status = ?',@bulletin.start_date,4])
				@experiences = Experience.where(['created_at >= ?',@bulletin.start_date])
				@user.each do |user|
					BulletinMailer.bulletin(@bulletin,user,@sections,@events,@offerings,@requests,@services,@experiences).deliver
				end
				format.html { redirect_to @bulletin, notice: 'Se ha enviado el boletín correctamente.' }
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
			params.require(:bulletin).permit(:title, :description, :start_date, :receiver)
		end

end
