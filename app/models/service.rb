class Service < ActiveRecord::Base
	#ENTIDAD SERVICE
	#Entidad que representa un servicio: Cuando una Oferta o Solicitud de Servicio (Publication) es aceptada tanto por un
	#usuario del tipo Profesor y otro del Tipo Socio comunitario, se genera un nuevo formulario en donde se
	#escribe el Servicio con sus características y fechas reales.

	#ATRIBUTOS:
	#title: Título del servicio, puede ser el mismo que la publición que lo genero
	#status: Estado en que se encuentra el servicio.
		#Este atributo es más complejo que una simple variable, ya que se va modificando dependiendo de el paso que se ecuentre.
		#Inicialmente el servicio se crea como recurso anidado del Publication y este tiene forma de mensaje, el cual es el 
		#primer nexo entre el profesor y el socio comunitario.
		#Luego puede pasar a estar activo, cuando este se esté realizando.
		#Finalmente pasa al estado Experiencia al momento de concretarse el Servicio.
	#message: este atributo es un mensaje que deje un usuario a otro para indicar que está interesado en participar 
		#de la actividad de Servicio. Es lo primero que se ve de Service.
	#description: hace referencia a la descripción del Servicio realizado.
	#resume: Resumen del servicio realizado.
	#start_time: Fecha de inicio de la actividad de Servicio.
	#end_time: Fecha de término de la actividad de Servicio.
	#learning_objectives: representa los objetivos de Aprendizaje que se planean al realizar el Servicio.
	#service_objectives representa los objetivos de Servicio que se planean al realizar el Servicio.

	#RELACIONES
	belongs_to :creator, :class_name=> "User" #Creador de la publicación (Offering o Request)
	belongs_to :acceptor, :class_name=> "User" #Usuario del otro tipo que aceptó trabajar en la oferta o solicitud.
	belongs_to :area
	belongs_to :institution
	belongs_to :publication, polymorphic: true #Hace referencia a la Oferta o Solicitud que dio paso inicial para este servicio.
	has_many :experiences
	has_many :comments, as: :post

	#Función que permite que el buscador encuentre Servicios a través de match de palabras en sus atributos.
	def self.search(search)
		where("title LIKE ? or message LIKE ? or description LIKE ? or resume LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end