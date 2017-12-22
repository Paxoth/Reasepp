=begin rdoc
_**Experience** es la entidad que representa a las experiencias de servicio, la etapa final del ciclo de vida de un servicio. Al ser finalmente un documento físico, tiene atributos que representan todos los campos de este documento._

**ATRIBUTOS**

*	__Formato de sitematización__ Gran parte de los atributos de experience representan al formulario que se debe llenar para completar el documento *“Formato Sistematización Actividades Aprendizaje Servicio"* 
    + description
    + faculty
    + department
    + region
    + comuna
    + course_name
    + course_type
    + course_type_other
    + period
    + professor_phone
    + professor_degree
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
*	__professor_id__: Hace referencia al profesor responsable del proyecto AS. (Ver entidad User)
*	__partner_id__: Hace referencia al socio colaborador del proyecto AS. (Ver entidad User)
*	__broker_id__: Hace referencia al vinculaor social que eventualmetne pudo haber tenido la idea de la actividad AS. (Ver entidad User)

**RELACIONES**

*   belongs_to proffesor ( User )
*   belongs_to partner ( User )
*   belongs_to Institution
*   belongs_to Area
*   belongs_to Service

=end
class Experience < ActiveRecord::Base

	#RELACIONES
	belongs_to :professor, :class_name=> "User"
	belongs_to :partner, :class_name=> "User"
	belongs_to :institution
	belongs_to :area
	belongs_to :service

    #Consulta por todas las experiencias entre dos fechas.
	scope :created_between, lambda {|start_date, end_date| where("created_at >= ? AND created_at <= ?", start_date, end_date )}
	
    #Consulta por todas las experiencias que pertenezcan a un área de trabajo.
    scope :by_area, ->(area_id) { where("area_id = ?", area_id)} 
	
	#Método que permite que el buscador encuentre Experiencias a través de match de palabras en sus atributos.
	def self.search(search)
		where("faculty LIKE ? or department LIKE ? or course_name LIKE ? or course_type LIKE ? or period LIKE ? or learning_objectives LIKE ? or service_objectives LIKE ? or benefited LIKE ? or results LIKE ? or tools LIKE ? or description LIKE ? or reflection_moments LIKE ? or title LIKE ?", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%" , "%#{search}%") 
	end
end