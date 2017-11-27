=begin rdoc
  _**Project PDF:** generador del documento .PDF de una experiencia documentada  (Ver Project)_
=end
class ProjectPdf < Prawn::Document
	#Funcion que inicializa el documento, dandole el formato respectivo.
	#
	#Llama a los métodos con la información de las experiencias.
	def initialize(project) 
		super(:margin => [90,90,90,90], :page_size=>'LETTER')
		@project = project
		logo = "#{Rails.root}/app/assets/images/LogoRease.png"
		image logo, scale: 0.4, position: :center, at: [140,670]
		project_title
		projects_general
		projects_information
		project_activity

	end

	#Título del pdf
	def project_title
		text "\n\nFORMATO SISTEMATIZACIÓN ACTIVIDADES APRENDIZAJE SERVICIO", size: 13, style: :bold, align: :center
		text "TÍTULO: #{@project.title}",size: 13, style: :bold, align: :center
		text "FOLIO N° #{@project.id}\nFecha: #{@project.created_at.strftime("%d/%m/%Y")}", size: 13, style: :bold, align: :center
	end

	#Información general de la experiencia
	def projects_general
		text "\n\n I Antecedentes generales:", size: 12, style: :bold
		text "\n<b>Universidad:</b> #{@project.institution.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Facultad:</b> #{@project.faculty}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Área de trabajo:</b> #{@project.area.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Departamento/Carrera:</b> #{@project.department}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nombre de asignatura/curso:</b> #{@project.course_name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		
		
		if @project.course_type == "Otro"
			text "\n<b>Tipo de asignatura/curso:</b> #{@project.course_type_other}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		else
			text "\n<b>Tipo de asignatura/curso:</b> #{@project.course_type}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end

		if @project.period == 1
			text "\n<b>Periodo:</b> Primer semestre", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @project.period == 2
			text "\n<b>Periodo:</b> Segundo semestre", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @project.period == 3
			text "\n<b>Periodo:</b> Cada semestre", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		else
			text "\n<b>Periodo:<b> Anual", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end
		
	end
	
	#Información sobre los responsables de la experiencia
	def projects_information
		text "\n\n II Datos de los responsables:", size: 12, style: :bold
		text "\n<b>Nombre profesor responsable:</b> #{@project.user.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Correo electrónico:</b> #{@project.user.email}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Teléfono:</b> #{@project.professor_phone}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		if @project.professor_degree == 1 
			text "\n<b>Grado académico docente responsable:</b> Licenciado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @project.professor_degree == 2 
			text "\n<b>Grado académico docente responsable:</b> Magister", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @project.professor_degree == 3 
			text "\n<b>Grado académico docente responsable:</b> Doctorado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end
		text "\n<b>Nombre del socio comunitario:</b> #{@project.partner}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
	end

	#Información sobre la actividad y sus objetivos
	def project_activity
		text "\n\n III Antecedentes de la actividad de Aprendizaje Servicio:", size: 12, style: :bold
		text "\n<b>Objetivos de aprendizaje y/o competencias asociadas:", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.learning_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Objetivo de servicio:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.service_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Descripción del proyecto AS:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.description}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>¿Con qué frecuencia se realiza?</b> #{@project.frequency}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Horas cronológicas semanales:</b> #{@project.weekly_hours}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Número de estudiantes participantes:</b> #{@project.participants}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nivel de la carrera de los estudiantes:</b> #{@project.students_level}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Números de beneficiados directos con toda la actividad o proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.benefited}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Resultados de aprendizaje:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.results}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Nombre herramientas de medición (cuali y/o cuantitativas) utilizadas y documentos que respalden el proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.tools}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Mencione las instancias de reflexión:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.reflection_moments}", size: 11, indent_paragraphs: 60, align: :justify
	end
end