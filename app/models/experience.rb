class Experience < ActiveRecord::Base
	#ENTIDAD EXPERIENCE
	#Entidad que representa las experiencias de servicio, nombre que reciben las actividaes AS, al ya haber sido
	#concretadas, es decir, una solicitud de servicio (modelo request) y una oferta de servicio (modelo offering)
	#pasan a ser una experiencia al ser concretadas.
	#ATRIBUTOS: 
		#Gran parte de los atributos de las experiencias de servicio son sacadas de un formulario que 
		#antiguamente completaban de forma manual llamado “Formato Sistematización Actividades Aprendizaje Servicio”.
			#Es por lo mismo que la cantidad de atributos es  considerablemente larga. 
			#description, faculty, department, course_name, course_type, course_type_other, period, 
			#professor_name, professor_email, professor_phone, professor_degree, learning_objectives, 
			#service_objectives, institutional_support, frequency, weekly_hours, participants, students_level, 
			#community_partner, organization_type, benefit, results, tools, reflection_moments
		#title: Título de la experiencia.
		#start_time: Fecha de inicio del proyecto AS.
		#end_time: Fecha de término del proyecto AS.

	#RELACIONES
	belongs_to :professor, :class_name=> "User"
	belongs_to :partner, :class_name=> "User"
	belongs_to :institution
	belongs_to :area
	belongs_to :service


	#Función para usar el buscador de experiencias de acuerdo algun match entre las palabras y los valores de los atributos de esta.
	def self.search(search)
		where("faculty LIKE ? or department LIKE ? or course_name LIKE ? or course_type LIKE ? or period LIKE ? or learning_objectives LIKE ? or service_objectives LIKE ? or benefit LIKE ? or results LIKE ? or tools LIKE ? or description LIKE ? or reflection_moments LIKE ? or title LIKE ?", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%" , "%#{search}%") 
	end
end