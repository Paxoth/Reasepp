=begin rdoc
_**Request** es la entidad que hace referencia a las Solicitudes de Servicio que pueden generar los usuarios que sean del tipo usuario Socio Comunitario. Estas deben ser aceptadas por un usuario del tipo Profesor para pasar a ser un Servicio.
._

**ATRIBUTOS**

*	__title__: Título de la Solicitud de Servicio.
*	__description__: Descripción general de la Solicitud de Servicio, en donde se dice qué es lo que se desea conseguir por realizar esta actividad.
*	__start_time__: Fecha que el profesor planifica que comience la actividad planeada.
*	__end_time__: Fecha que el profesor planifica que termine la actividad planeada.
*	__resume__: Descripción breve de la Solicitud de Servicio, la cual será mostrada en las listas de Solicituds.
*	__status__: estado del Servicio
    1. Disponible: está dentro de las fechas estimada.
    2. Cancelado: la Solicitud de Servcio fue cancelada por el profesor
    3. Caducado: ha pasado el tiempo estimado y la Solicitud ha caducado.
    4. Servicio: Cuando un profesor y un socio comunitario se ponen de acuerdo, la Solicitud de Servicio pasa a estar en un estado de Servicio, para el cual se crea otro formulario (Ver entidad Service)
*   __location__: Lugar donde se realizará la actividad (Trabajos futuros, conectar a GoogleMaps)

**RELACIONES**

*	belongs_to User
*	belongs_to Area
*	belongs_to Institution
*	has_many Comment como 'post'
*	has_many Experience como 'servicio'
*	has_many Services como 'publication'

=end
class Request < ActiveRecord::Base
	#RELACIONES
	belongs_to :user
	belongs_to :area
	belongs_to :institution
	has_many :comments, as: :post
	has_many :experiences, as: :servicio
	has_many :services, as: :publication

	#ATRIBUTOS:

	
	#VALIDACIONES
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 27, maximum: 10000} #validar maximos y minimos de caracteres
	validates :status, presence: true
	validates :resume, presence: true, length:{minimum:10, maximum:300}

	#Método que permite que el buscador encuentre Solicitudes de Servicios a través de match de palabras en sus atributos.
	def self.search(search)
		where("title LIKE ? or description LIKE ? or resume LIKE ?", "%#{search}%","%#{search}%", "%#{search}%") 
	end
end
