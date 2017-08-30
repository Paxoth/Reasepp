#https://www.youtube.com/watch?v=e-A3zBeWDdE

#margin arriba 1.24 abajo 2.5 abajo 3 y 3
class ExperiencePdf < Prawn::Document
	def initialize(experience) 
		super(:margin => [90,90,90,90], :page_size=>'LETTER')
		@experience = experience
		logo = "#{Rails.root}/app/assets/images/LogoRease.png"
		image logo, scale: 0.4, position: :center, at: [140,670]
		experience_title
		experiences_general
		experience_activity

	end

	def experience_title
		text "\n\nFORMATO SISTEMATIZACIÓN ACTIVIDADES APRENDIZAJE SERVICIO", size: 13, style: :bold, align: :center
		text "TÍTULO: #{@experience.title}",size: 13, style: :bold, align: :center
		text "FOLIO N° #{@experience.id}\nFecha: #{@experience.created_at.strftime("%d/%m/%Y")}", size: 13, style: :bold, align: :center
	end

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

		text "\n<b>Nombre profesor responsable:</b> #{@experience.professor_name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Correo electrónico:</b> #{@experience.professor_email}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Teléfono:</b> #{@experience.professor_phone}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true

		if @experience.professor_degree == 1 
			text "\n<b>Grado académico docente responsable:</b> Licenciado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @experience.professor_degree == 2 
			text "\n<b>Grado académico docente responsable:</b> Magister", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		elsif @experience.professor_degree == 3 
			text "\n<b>Grado académico docente responsable:</b> Doctorado", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		end
		
	end
	
	def experience_activity
		text "\n\n II Antecedentes de la actividad de Aprendizaje Servicio:", size: 12, style: :bold
		text "\n<b>Objetivos de aprendizaje y/o competencias asociadas:", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.learning_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Objetivo de servicio:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.service_objectives}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Descripción del proyecto AS:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.description}", size: 11, indent_paragraphs: 60, align: :justify

		if @experience.institutional_support == 1
			text "\n<b>Respaldo institucional:</b> Cuenta con respaldo institucional.", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true, :inline_format => true
		elsif @experience.institutional_support == 2
			text "\n<b>Respaldo institucional:</b> Corresponde a una iniciativa individual del profesor.", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true, :inline_format => true
		end

		text "\n<b>¿Con qué frecuencia se realiza?</b> #{@experience.frequency}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Horas cronológicas semanales:</b> #{@experience.weekly_hours}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Número de estudiantes participantes:</b> #{@experience.participants}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nivel de la carrera de los estudiantes:</b> #{@experience.students_level}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Nombre del socio comunitario:</b> #{@experience.partner.name}", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n<b>Números de beneficiados directos con toda la actividad o proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.benefit}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Resultados de aprendizaje:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.results}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Nombre herramientas de medición (cuali y/o cuantitativas) utilizadas y documentos que respalden el proyecto:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.tools}", size: 11, indent_paragraphs: 60, align: :justify
		text "\n<b>Mencione las instancias de reflexión:</b>", size: 11, indent_paragraphs: 30, align: :justify, :inline_format => true
		text "\n#{@experience.reflection_moments}", size: 11, indent_paragraphs: 60, align: :justify
	end
end