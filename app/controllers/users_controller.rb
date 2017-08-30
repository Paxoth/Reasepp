class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :validate_category, only: [:edit,:update]
	before_action :set_user, only: [:show, :edit, :update, :finish_signup]
	add_breadcrumb "Inicio", :root_path

	def index
		add_breadcrumb "Perfil", :users_path
		@user = current_user
	end

	def listarUsuarios
		add_breadcrumb "Usuarios registrados"
		@user = User.paginate(page: params[:page],per_page: 20).order("nickname ASC").all
	end
	
	def show
		add_breadcrumb "Perfil", :users_path
		add_breadcrumb "Perfil de "+@user.nickname
	end

	def edit
		add_breadcrumb "Perfil", :users_path
		add_breadcrumb "Editar perfil de "+@user.nickname
	end

	def update
		# authorize! :update, @user
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

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to users_listarUsuarios_path, notice: "El usuario ha sido eliminado"
		end
	end

	# GET/PATCH /users/:id/finish_signup
	def finish_signup
		@sections = Section.all
		# authorize! :update, @user 
		if request.patch? && params[:user] #&& params[:user][:email]
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

	def validate_category
		if current_user.category != 1
			redirect_to root_path, alert: "Solo el administrador tiene este privilegio"
		end   
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_user
		@user = User.find(params[:id])
	end
	
	def user_params
		accessible = [ :name, :email,:category,:autorization_level,:nickname ] # extend with your own params
     	accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      	params.require(:user).permit(accessible)
	end
end
