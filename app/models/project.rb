class Project < ActiveRecord::Base
	#ENTIDAD PROJECT
	#Entidad que representa las experiencias de servicio, pero que no fueron formadas por parte de las activdades de servicio del sistema REASE.
	#A diferenciad e Experience no tiene relación directa con las demas actividades de servicio, sino que simplemente, 
	#es un formulario que puede llenar manualmente un usuario.

	#ATRIBUTOS: 
		#Los atributos de los proyectos de servicio son sacadas de un formulario que 
		#antiguamente completaban de forma manual llamado “Formato Sistematización Actividades Aprendizaje Servicio”.
			#Es por lo mismo que la cantidad de atributos es  considerablemente larga. 
			#description, faculty, department, course_name, course_type, course_type_other, period, 
			#professor_name, professor_email, professor_phone, professor_degree, learning_objectives, 
			#service_objectives, frequency, weekly_hours, participants, students_level, 
			#community_partner, organization_type, benefited, results, tools, reflection_moments
		#title: Título de la proyecto.
		#start_time: Fecha de inicio del proyecto AS.
		#end_time: Fecha de término del proyecto AS.

	#RELACIONES
	belongs_to :area
	belongs_to :user
	belongs_to :institution

	#Función que permite que el buscador encuentre Proyectos a través de match de palabras en sus atributos.
	def self.search(search)
		where("faculty LIKE ? or department LIKE ? or course_name LIKE ? or course_type LIKE ? or period LIKE ? or learning_objectives LIKE ? or service_objectives LIKE ? or benefited LIKE ? or results LIKE ? or tools LIKE ? or description LIKE ? or reflection_moments LIKE ? or title LIKE ?", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%" , "%#{search}%") 
	end
end
