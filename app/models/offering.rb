=begin rdoc
_**Offering** es la entidad que hace referencia a las Ofertas de Servicio que pueden generar los usuarios que sean del tipo usuario profesor
Estas deben ser aceptadas por un usuario del tipo socio comunitario._

**ATRIBUTOS**

*	__title__: Título de la Oferta de Servicio.
*	__description__: Descripción general de la Oferta de Servicio, en donde se dice qué es lo que se desea conseguir por realizar esta actividad.
*	__start_time__: Fecha que el profesor planifica que comience la actividad planeada.
*	__end_time__: Fecha que el profesor planifica que termine la actividad planeada.
*	__resume__: Descripción breve de la Oferta de Servicio, la cual será mostrada en las listas de Ofertas.
*	__status__: estado del Servicio
    1. Disponible: está dentro de las fechas estimada.
    2. Cancelado: la Oferta de Servcio fue cancelada por el profesor
    3. Caducado: ha pasado el tiempo estimado y la Oferta ha caducado.
    4. Servicio: Cuando un profesor y un socio comunitario se ponen de acuerdo, la Oferta de Servicio pasa a estar en un estado de Servicio, para el cual se crea otro formulario (Ver entidad Service)
*   __location__: Lugar donde se realizará la actividad (Trabajos futuros, conectar a GoogleMaps)

**RELACIONES**

*	belongs_to User
*	belongs_to Area
*	belongs_to Institution
*	has_many Comment como 'post'
*	has_many Experience como 'servicio'
*	has_many Services como 'publication'
=end
class Offering < ActiveRecord::Base

	#RELACIONES
	belongs_to :user
	belongs_to :area
	belongs_to :institution
	has_many :comments, as: :post
	has_many :experiences, as: :servicio
	has_many :services, as: :publication
	
	#VALIDACIONES
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 27, maximum: 10000} #validar maximos y minimos de caracteres
	validates :status, presence: true
	validates :resume, presence: true, length:{minimum:10, maximum:300}

	#Método que permite que el buscador encuentre Ofertas de Servicios a través de match de palabras en sus atributos.
	def self.search(search)
		where("title LIKE ? or description LIKE ? or resume LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end
