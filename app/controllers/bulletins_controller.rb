=begin rdoc
  _**Bulletin** controlador de los Boletines (Ver Bulletin)_
=end
class BulletinsController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, except: [:show]
	before_action :set_bulletin, only: [:show, :update, :destroy]
	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Administración", :sections_path, except:[:show]
	add_breadcrumb "Boletines", :bulletins_path, except:[:show]

	#Vista Principal
	#
	#Genera la consulta de todos los Bulletin páginados en 5 elementos
	def index
		@bulletins = Bulletin.paginate(page: params[:page],per_page: 5).all
	end

	#Vista específica
	#
	#Muestra la vista de un boletín en específico clasificado por ID
	#Muestra la información de los últimas actividades del sitio.
	def show
		if current_user.is_admin?
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

	#Vista Nuevo boletín
	#
	#Pérmite la creación de un nuevo boletín
	def new
		@bulletin = Bulletin.new
	end

	#Crear Boletín
	#
	#Genera el nuevo boletín con los parametros permitidos de la clase Area y redirecciona la vista de esta.
	#
	#Utiliza la función de BulletinMailer para enviar los correos a los respectivos usuarios.
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

	#Actualizar Boletín
	#Función generada por scaffold, nunca utilizada
	def update # :nodoc:
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

	#Eliminar Boletín
	#Función generada por scaffold, nunca utilizada
	def destroy # :nodoc:
		@bulletin.destroy
		respond_to do |format|
			format.html { redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
		#Solo los administradores pueden acceder a las vistas de Bulletin y generarlos.
		def validate_category # :doc:
			if !current_user.is_admin?
				redirect_to root_path, alert: "Sólo un administrador puede trabajar la página de inicio."
			end   
		end

		#Permite la consulta específica de un Bulletin
		#Utilizado para la vista específica.
		def set_bulletin # :doc:
			@bulletin = Bulletin.find(params[:id])
		end

		#Parametros permitidos para creación un boletín.
		def bulletin_params # :doc:
			params.require(:bulletin).permit(:title, :description, :start_date, :receiver)
		end

end
