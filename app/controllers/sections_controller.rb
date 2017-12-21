=begin rdoc
  _**Section:** controlador de las secciones (Ver Section).

  A diferenca se crean estos controladores para administrar las secciones, poder crear y editar datos del portal Web._
=end
class SectionsController < ApplicationController
	before_action :authenticate_user!, except: [:show]
	before_action :validate_category, except: [:show]
	before_action :administration

	add_breadcrumb "Inicio", :root_path
	add_breadcrumb "Administración", :sections_path

	#Vista principal de administración.
	#Solo desplegará botones par aacceder a diferentes vistas administrativas.
	def index
	end

	#Vista de administrar módulo de novedades.
	#
	#Se genera la consulta de todas las secciones que pertenezcan al módulo "Novedad"
	def novedades
		add_breadcrumb "Novedades", :sections_novedades_path
		@sections = Section.order("priority ASC").where("module = ?","Novedad")
	end

	#Vista de administrar módulo de ¿Quiénes somos?
	#
	#Se genera la consulta de todas las secciones que pertenezcan al módulo "Somos".
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def somos
		add_breadcrumb "¿Quienes Somos?", :sections_somos_path
		@sections = Section.order("priority ASC").where("module = ?","Somos")
	end

	#Vista de administrar módulo de ¿Qué hacemos?
	#
	#Se genera la consulta de todas las secciones que pertenezcan al módulo "Hacemos".
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def hacemos
		add_breadcrumb "¿Qué hacemos?", :sections_hacemos_path
		@sections = Section.order("priority ASC").where("module = ?","Hacemos")
	end

	#Vista de administrar módulo de Estatuto
	#
	#Se genera la consulta de todas las secciones que pertenezcan al módulo "Estatuto".
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def estatuto
		add_breadcrumb "Estatuto", :sections_estatuto_path
		@sections = Section.order("created_at ASC").where("module = ?","Estatuto")
	end

	#Vista de administrar módulo de Aprendizaje Servicio
	#
	#Se genera la consulta de todas las secciones que pertenezcan al módulo "Aprendizaje Servicio".
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def aprendizaje
		add_breadcrumb "Aprendizaje Servicio", :sections_aprendizaje_path
		@sections = Section.order("priority ASC").where("module = ?","Aprendizaje Servicio")
	end

	#Vista de crear módulo de novedades.
	#
	#Se crea una vista específica con el objetivo de que la sección automáticamente perteneciera al respectivo módulo. Se cree que estas vistas son optimizables.
	def newNovedades
		add_breadcrumb "Novedades", :sections_novedades_path
		add_breadcrumb "Nuevo"
	end

	#Vista de crear módulo de ¿Quiénes somos?.
	#
	#Se crea una vista específica con el objetivo de que la sección automáticamente perteneciera al respectivo módulo. Se cree que estas vistas son optimizables.
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def newSomos
		add_breadcrumb "¿Quienes Somos?", :sections_somos_path
		add_breadcrumb "Nuevo"
	end

	#Vista de crear módulo de ¿Qué hacemos?.
	#
	#Se crea una vista específica con el objetivo de que la sección automáticamente perteneciera al respectivo módulo. Se cree que estas vistas son optimizables.
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def newHacemos
		add_breadcrumb "¿Qué hacemos?", :sections_hacemos_path
		add_breadcrumb "Nuevo"
	end

	#Vista de crear módulo de Estatuto.
	#
	#Se crea una vista específica con el objetivo de que la sección automáticamente perteneciera al respectivo módulo. Se cree que estas vistas son optimizables.
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def newEstatuto
		add_breadcrumb "Estatuto", :sections_estatuto_path
		add_breadcrumb "Nuevo"
	end

	#Vista de crear módulo de Aprendizaje Servicio.
	#
	#Se crea una vista específica con el objetivo de que la sección automáticamente perteneciera al respectivo módulo. Se cree que estas vistas son optimizables.
	#
	#Sección eliminada, nuevo objetivo de la plataforma la hace innecesaria
	def newAprendizaje
		add_breadcrumb "Aprendizaje Servicio", :sections_aprendizaje_path
		add_breadcrumb "Nuevo"
	end

	#Vista de crear Section
	#
	#No utilizada comunmnete, se cree que se generó para poder generar secciones sin necesidad de tener claro a qué módulo pertenece. Se estima que debe mejorarse.
	def new
		add_breadcrumb "Nueva sección", :new_section_path
		@section = Section.new
	end

	#Vista específica de una sección
	#
	#Se genera la consula de una sección por su ID.
	def show
		@section = Section.find(params[:id])
	end

	#Crear sección
	#
	#Método que permite crear una seccion.
	def create
		@section = current_user.sections.new(section_params)
		@section.module = "Novedad"
		if @section.save
			redirect_to sections_path
			flash[:notice] = "La noticia ha sido creada correctamente"
		else
			render :new #en caso de que no guarde redirecciona a la misma pagina
		end
	end

	#Eliminar sección
	#
	#Método que permite eliminar una seccion.
	def destroy
		@section = Section.find(params[:id])
		@section.destroy
		flash[:notice] = "La sección ha sido eliminada correctamente"
		redirect_to sections_path
	end

	#Vista de editar sección
	#
	#Vista que permite editar una seccion a partir de una consulta por ID.
	def edit
		add_breadcrumb "Editar sección", :edit_section_path
		@section = Section.find(params[:id])
	end

	#Éditar sección
	#
	#Método que permite editar una seccion a partir de una consulta por ID.
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

	#Valida que solo los administradores sean capaces de entrar en estas vistas administrativas.
	def validate_category # :doc:
		if !current_user.is_admin?
			redirect_to root_path, alert: "Sólo un administrador puede trabajar la página de inicio."
		end   
	end

	def administration
		@section = Section.new		
	end

	def section_params
		params.require(:section).permit(:title,:body,:module,:priority, :user_id)
	end
end