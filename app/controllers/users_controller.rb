=begin rdoc
  _**User:** controlador de los Usuarios (Ver User)_
  _Este controlador de usuarios se complementa con los de Devise, permitinedo la edición de perfiles, entre otras funcionalidades._
=end
class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, only: [:edit,:update]
	before_action :set_user, only: [:show, :edit, :update, :finish_signup]
	add_breadcrumb "Inicio", :root_path

	#Perfil propio: Vista principal del usuario
	#
	#Se generan las consultas respectivas para mostrar todas las actividades AS generadas por el usuario.
	#
	#* Offering
	#* Request
	#* Experience
	def index
		add_breadcrumb "Perfil", :users_path
		@user = current_user

		#Consultar por las actividades de servicio en estado de licitación que posee cada usuario.
		if @user.category == 2
			@offerings = Offering.where(user: @user,status: 1)
			@experiences = Experience.where(professor_id: @user.id)
		elsif @user.category == 4
			@requests = Request.where(user: @user,status: 1)
			@experiences = Experience.where(partner_id: @user.id)
		elsif @user.category == 3
			@offerings = Offering.where(broker_id: @user.id,status: 1)
			@requests = Request.where(broker_id: @user.id,status: 1)
			@experiences = Experience.where(broker_id: @user.id)
		end
	end

	#Vista para lo administradores.
	#Donde pueden ver a todos los usuarios registrados con sus datos.
	#Acá los adminstradores podrán cambiar la categoría de los usuarios y nombrarlos administradores.
	def listarUsuarios
		add_breadcrumb "Usuarios registrados"
		@user = User.paginate(page: params[:page],per_page: 20).order("nickname ASC").all
	end
	
	#Perfil externo: vista específica
	#
	#Se pueden ver los perfiles de otros usuarios y sus respectivas actividades AS.
	def show
		add_breadcrumb "Perfil", :users_path
		add_breadcrumb "Perfil de "+@user.nickname
		#Consultar por las actividades de servicio en estado de licitación que posee cada usuario.
		if @user.category == 2
			@offerings = Offering.where(user: @user,status: 1)
			@experiences = Experience.where(professor_id: @user.id)
		elsif @user.category == 4
			@requests = Request.where(user: @user,status: 1)
			@experiences = Experience.where(partner_id: @user.id)
		elsif @user.category == 3
			@offerings = Offering.where(broker_id: @user.id,status: 1)
			@requests = Request.where(broker_id: @user.id,status: 1)
			@experiences = Experience.where(broker_id: @user.id)
		end
	end

	def edit # :nodoc:
		add_breadcrumb "Perfil", :users_path
		add_breadcrumb "Editar perfil de "+@user.nickname
	end

	def update # :nodoc:
		respond_to do |format|
			if @user.update(user_params)
				sign_in(@user == current_user ? @user : current_user, :bypass => true)
				format.html { redirect_to @user, notice: 'El perfil se ha actualizado correctamente.' }
				format.json { head :no_content }
			else
				format.html { render action: 'edit' }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy # :nodoc:
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to users_listarUsuarios_path, notice: "El usuario ha sido eliminado"
		end
	end

	# Método que permite el registro correcto de los usuarios a través de confirmaciones.
	def finish_signup
		@sections = Section.all
		if request.patch? && params[:user] 
			if @user.update(user_params)
				# @user.skip_reconfirmation!
				sign_in(@user, :bypass => true)
				redirect_to users_path, notice: 'El perfil ha sido a registrado, confirme su cuenta en su correo electŕonico'
			else
				@show_errors = true
			end
		end
	end

	
	private

	#Valida que solo un adminstrador pueda acceder a ciertas vistas de los usuarios.
	def validate_category # :doc:
		if !current_user.is_admin?
			redirect_to root_path, alert: "Solo el administrador tiene este privilegio"
		end   
	end

	def set_user
		@user = User.find(params[:id])
	end
	
	def user_params
		accessible = [ 
			:name, 
			:email,
			:category,
			:autorization_level,
			:nickname, 
			:is_admin,
			:facebook,
			:instagram,
			:linkedin,
			:twitter,
			:youtube ] # extend with your own params
     	accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      	params.require(:user).permit(accessible)
	end
end
