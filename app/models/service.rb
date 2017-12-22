=begin rdoc
_**Service** es la entidad que representa a los servicios activos de la intranet, el cual es el punto medio que indica que dos usuarios aceptaron colaborar juntos en un proyecto AS.
Service tiene un comportamiento **polimórfico** para su relación con la publicación anterior (Ver Offering y Request).
Además tiene dos relaciones con User, una para saber quién es el creador de la actividad AS y otro para el que aceptó trabajar con él.
El profesor siempre será el responsable de la actividad._

**ATRIBUTOS**

*	__publication_id__: Hace referencia  a la publicación previa que dio pie a este servicio activo (Oferta o Solicitud)
*	__publication_type__: índica si la publicación previa que dio pie a este servicio es una oferta o una solicitud.
*	__creator_id__: Hace referencia al usuario que creó la publicación que dio pie a este servicio.
*	__acceptor_id__: Hace referencia al usuario que colaborará con el creador de la publicación.
*	__title__: Título del servicio activo.
*	__status__: es el estado en que se encuentra el servicio
    1. Pendiente: La creación de un servicio parte como un mensaje en una Oferta o Solicitud, que cuando no se es respondida se encuentra en este estado.
    2. Aceptado: Cuando el creador de la oferta acepta trabajar con el creador del servicio en forma de mensaje, pasa el servicio en estado aceptado.
    3. Rechazado: Cuando el creador de la oferta desiste trabajar con el creador del servicio en forma de mensaje, este servicio es rechazado.
    4. Activo: Cuando el servicio es aceptado y está dentro de sus periodos de __start_time__ y __end_time__ se encuentra activo.
    5. Experiencia: Cuando el servicio se concreta de manera correcta el profesor responsable debe crear una Experiencia (Ver Experience)
*   __message__: Mensaje que deja un usuario para manifestar interés de trabajar junto al creador de la publicación previa que dio pie al servicio.           
*   __description__: Descripción del servicio activo.
*   __resume__:  Breve resumen del servicio activo el cuál se mostrará en un principio.
*   __start_time__: Fecha de inicio del proyecto AS.
*   __end_time__: Fecha de término del proyecto AS.
*   __learning_objectives__: representa los objetivos de aprendizaje del proyecto AS.
*   __service_objectives__: representa los objetivos de servicio del proyecto AS.
*	__broker_id__: Hace referencia al usuario vinculador social que potencialmente podría haber creado la publicación inicial y otorgado la responsabilidad.

**RELACIONES**

*   belongs_to creator ( User ): creador de la publicación
*   belongs_to acceptor ( User ): usuario que acepta trabajar con el creador
*   belongs_to Institution
*   belongs_to Publication (Polimorfismo)
    + Offering
    + Request
*   has_many Experience
*   has_many Comment como 'post'

=end

class Service < ActiveRecord::Base
	#RELACIONES
	belongs_to :creator, :class_name=> "User" #Creador de la publicación (Offering o Request)
	belongs_to :acceptor, :class_name=> "User" #Usuario del otro tipo que aceptó trabajar en la oferta o solicitud.
	belongs_to :area
	belongs_to :institution
	belongs_to :publication, polymorphic: true #Hace referencia a la Oferta o Solicitud que dio paso inicial para este servicio.
	has_many :experiences
	has_many :comments, as: :post

	#Método que permite que el buscador encuentre Servicios a través de match de palabras en sus atributos.
	def self.search(search)
		where("title LIKE ? or message LIKE ? or description LIKE ? or resume LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end