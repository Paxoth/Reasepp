=begin rdoc
  _**Experience PDF:** generador del documento .PDF de una experiencia de servicio (Ver Experience)_
=end
class ExperiencePdf < Prawn::Document
	#Funcion que inicializa el documento, dandole el formato respectivo.
	#
	#Llama a los métodos con la información de las experiencias.
	def initialize(experience) 
		super(:margin => [90,90,90,90], :page_size=>'LETTER')
		@experience = experience
		if @experience.broker_id.present?
			@broker = User.where(id:@experience.broker_id).first
		end
		logo = "#{Rails.root}/app/assets/images/LogoRease.png"
		image logo, scale: 0.4, position: :center, at: [140,670]
		experience_title
		experiences_general
		experiences_information
		experience_activity

	end

	#Título del pdf
	def experience_title
		text "\n\nFORMATO SISTEMATIZACIÓN ACTIVIDADES APRENDIZAJE SERVICIO", size: 13, style: :bold, align: :center
		text "TÍTULO: #{@experience.title}",size: 13, style: :bold, align: :center
		text "FOLIO N° #{@experience.id}\nFecha: #{@experience.created_at.strftime("%d/%m/%Y")}", size: 13, style: :bold, align: :center
	end

	#Información general de la experiencia
	def experiences_general
		text "\n\n I Antecedentes generales:", size: 12, style: :bold
		text "\n<b>Universidad:</b> #{@experience.institution.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Facultad:</b> #{@experience.faculty}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Área de trabajo:</b> #{@experience.area.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Departamento/Carrera:</b> #{@experience.department}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nombre de asignatura/curso:</b> #{@experience.course_name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		
		
		if @experience.course_type == "Otro"
			text "\n<b>Tipo de asignatura/curso:</b> #{@experience.course_type_other}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		else
			text "\n<b>Tipo de asignatura/curso:</b> #{@experience.course_type}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end

		if @experience.period == 1
			text "\n<b>Periodo:</b> Primer semestre", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @experience.period == 2
			text "\n<b>Periodo:</b> Segundo semestre", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @experience.period == 3
			text "\n<b>Periodo:</b> Cada semestre", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		else
			text "\n<b>Periodo:<b> Anual", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end
		
	end
	
	#Información sobre los responsables de la experiencia
	def experiences_information
		text "\n\n II Datos de los responsables:", size: 12, style: :bold
		text "\n<b>Nombre profesor responsable:</b> #{@experience.professor.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Correo electrónico:</b> #{@experience.professor.email}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Teléfono:</b> #{@experience.professor_phone}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true

		if @experience.professor_degree == 1 
			text "\n<b>Grado académico docente responsable:</b> Licenciado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @experience.professor_degree == 2 
			text "\n<b>Grado académico docente responsable:</b> Magister", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @experience.professor_degree == 3 
			text "\n<b>Grado académico docente responsable:</b> Doctorado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end
		text "\n<b>Nombre del socio comunitario:</b> #{@experience.partner.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		if @broker.present?
			text "\n<b>Nombre del vinculador social:</b> #{@broker.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end
	end

	#Información sobre la actividad y sus objetivos
	def experience_activity
		text "\n\n III Antecedentes de la actividad de Aprendizaje Servicio:", size: 12, style: :bold
		text "\n<b>Objetivos de aprendizaje y/o competencias asociadas:", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.learning_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Objetivo de servicio:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.service_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Descripción del proyecto AS:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.description}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>¿Con qué frecuencia se realiza?</b> #{@experience.frequency}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Horas cronológicas semanales:</b> #{@experience.weekly_hours}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Número de estudiantes participantes:</b> #{@experience.participants}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nivel de la carrera de los estudiantes:</b> #{@experience.students_level}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Números de beneficiados directos con toda la actividad o proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.benefited}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Resultados de aprendizaje:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.results}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Nombre herramientas de medición (cuali y/o cuantitativas) utilizadas y documentos que respalden el proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.tools}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Mencione las instancias de reflexión:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.reflection_moments}", size: 11, indent_paragraphs: 60, align: :justify
	end
end