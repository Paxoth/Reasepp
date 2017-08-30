#https://www.youtube.com/watch?v=e-A3zBeWDdE

#margin arriba 1.24 abajo 2.5 abajo 3 y 3
class ProjectPdf < Prawn::Document
	def initialize(project) 
		super(:margin => [90,90,90,90], :page_size=>'LETTER')
		@project = project
		logo = "#{Rails.root}/app/assets/images/LogoRease.png"
		image logo, scale: 0.4, position: :center, at: [140,670]
		project_title
		projects_general
		project_activity

	end

	def project_title
		text "\n\nFORMATO SISTEMATIZACIÓN ACTIVIDADES APRENDIZAJE SERVICIO", size: 13, style: :bold, align: :center
		text "TÍTULO: #{@project.title}",size: 13, style: :bold, align: :center
		text "FOLIO N° #{@project.id}\nFecha: #{@project.created_at.strftime("%d/%m/%Y")}", size: 13, style: :bold, align: :center
	end

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

		text "\n<b>Nombre profesor responsable:</b> #{@project.professor_name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Correo electrónico:</b> #{@project.professor_email}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Teléfono:</b> #{@project.professor_phone}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true

		if @project.professor_degree == 1 
			text "\n<b>Grado académico docente responsable:</b> Licenciado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @project.professor_degree == 2 
			text "\n<b>Grado académico docente responsable:</b> Magister", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @project.professor_degree == 3 
			text "\n<b>Grado académico docente responsable:</b> Doctorado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end
		
	end
	
	def project_activity
		text "\n\n II Antecedentes de la actividad de Aprendizaje Servicio:", size: 12, style: :bold
		text "\n<b>Objetivos de aprendizaje y/o competencias asociadas:", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.learning_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Objetivo de servicio:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.service_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Descripción del proyecto AS:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.description}", size: 11, indent_paragraphs: 60, align: :justify

		if @project.institutional_support == 1
			text "\n<b>Respaldo institucional:</b> Cuenta con respaldo institucional.", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true, :inline_format => true
		elsif @project.institutional_support == 2
			text "\n<b>Respaldo institucional:</b> Corresponde a una iniciativa individual del profesor.", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true, :inline_format => true
		end

		text "\n<b>¿Con qué frecuencia se realiza?</b> #{@project.frequency}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Horas cronológicas semanales:</b> #{@project.weekly_hours}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Número de estudiantes participantes:</b> #{@project.participants}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nivel de la carrera de los estudiantes:</b> #{@project.students_level}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nombre del socio comunitario:</b> #{@project.partner}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Números de beneficiados directos con toda la actividad o proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.benefit}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Resultados de aprendizaje:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.results}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Nombre herramientas de medición (cuali y/o cuantitativas) utilizadas y documentos que respalden el proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.tools}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Mencione las instancias de reflexión:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@project.reflection_moments}", size: 11, indent_paragraphs: 60, align: :justify
	end
end