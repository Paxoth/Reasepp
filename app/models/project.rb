=begin rdoc
_**Project** es la entidad que representa las experiencias de servicio documentadas, es decir, que no fueron formadas por parte de las activdades de servicio del sistema REASE. 
A diferencia de Experience no tiene relación directa con las demas actividades de servicio, sino que simplemente, es un formulario que puede llenar manualmente un usuario con el objeto de digitalizar experiencias previamente realizadas a la creación de REASE._

**ATRIBUTOS**

*	__Formato de sitematización__ Gran parte de los atributos de Project representan al formulario que se debe llenar para completar el documento *“Formato Sistematización Actividades Aprendizaje Servicio"* 
    + description
    + faculty
    + department
    + course_name
    + course_type
    + course_type_other
    + period
    + professor_name
    + professor_phone
    + professor_degree
    + community_partner
    + learning_objectives
    + service_objectives
    + frequency
    + weekly_hours
    + participants
    + students_level
    + community_partner
    + organization_type
    + benefited
    + results
    + tools
    + reflection_moments	
*	__title__: Título de la experiencia.
*	__start_time__: Fecha de inicio del proyecto AS.
*	__end_time__: Fecha de término del proyecto AS.

**RELACIONES**

*   belongs_to Institution
*   belongs_to Area
*   belongs_to User 
=end
class Project < ActiveRecord::Base
	#RELACIONES
	belongs_to :area
	belongs_to :user
	belongs_to :institution

	#Método que permite que el buscador encuentre Proyectos a través de match de palabras en sus atributos.
	def self.search(search)
		where("faculty LIKE ? or department LIKE ? or course_name LIKE ? or course_type LIKE ? or period LIKE ? or learning_objectives LIKE ? or service_objectives LIKE ? or benefited LIKE ? or results LIKE ? or tools LIKE ? or description LIKE ? or reflection_moments LIKE ? or title LIKE ?", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%" , "%#{search}%") 
	end
end
