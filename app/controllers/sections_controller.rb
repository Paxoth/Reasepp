class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :validate_category, except: [:show]
	before_action :administration

	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Administración", :sections_path

	def index
	end
	def novedades
		add_breadcrumb "Novedades", :sections_novedades_path
		@sections = Section.order("priority ASC").where("module = ?","Novedad")
	end
	def somos
		add_breadcrumb "¿Quienes Somos?", :sections_somos_path
		@sections = Section.order("priority ASC").where("module = ?","Somos")
	end
	def hacemos
		add_breadcrumb "¿Qué hacemos?", :sections_hacemos_path
		@sections = Section.order("priority ASC").where("module = ?","Hacemos")
	end
	def estatuto
		add_breadcrumb "Estatuto", :sections_estatuto_path
		@sections = Section.order("created_at ASC").where("module = ?","Estatuto")
	end
	def aprendizaje
		add_breadcrumb "Aprendizaje Servicio", :sections_aprendizaje_path
		@sections = Section.order("priority ASC").where("module = ?","Aprendizaje Servicio")
	end
	def newNovedades
		add_breadcrumb "Novedades", :sections_novedades_path
		add_breadcrumb "Nuevo"
	end
	def newSomos
		add_breadcrumb "¿Quienes Somos?", :sections_somos_path
		add_breadcrumb "Nuevo"
	end
	def newHacemos
		add_breadcrumb "¿Qué hacemos?", :sections_hacemos_path
		add_breadcrumb "Nuevo"
	end
	def newEstatuto
		add_breadcrumb "Estatuto", :sections_estatuto_path
		add_breadcrumb "Nuevo"
	end
	def newAprendizaje
		add_breadcrumb "Aprendizaje Servicio", :sections_aprendizaje_path
		add_breadcrumb "Nuevo"
	end

	def new
		add_breadcrumb "Nueva sección", :new_section_path
		@section = Section.new
	end

	def show
		@section = Section.find(params[:id])
	end

	def create
		@section = Section.new(section_params)
		if @section.save
			redirect_to sections_path
			flash[:notice] = "La sección ha sido creada correctamente"
		else
			render :new #en caso de que no guarde redirecciona a la misma pagina
		end
	end

	def destroy
		@section = Section.find(params[:id])
		@section.destroy
		flash[:notice] = "La sección ha sido eliminada correctamente"
		redirect_to sections_path
	end

	def edit
		add_breadcrumb "Editar sección", :edit_section_path
		@section = Section.find(params[:id])
	end

	def update
		@section = Section.find(params[:id])
		if @section.update(section_params)
			flash[:notice] = "La sección ha sido actualizada correctamente"
			redirect_to @section
		else
			flash[:alert] = "Ha ocurrido un error en la actualización de la sección"
			render :edit
		end
	end

	private #acciones privadas del controlador

	def validate_category
		if current_user.category != 1
		redirect_to root_path, alert: "Sólo un administrador puede trabajar la página de inicio."
		end   
	end

	def administration
		@section = Section.new		
	end

	def section_params
		params.require(:section).permit(:title,:body,:module,:priority)
	end
end