=begin rdoc
_**Events** es la entidad que representa los eventos que se pueden generar en la página de REASE. Son los eventos a los que invita a participar la red. Solo puede crearlo el administrador._

**ATRIBUTOS**

*	__title__: Título del evento.
*	__description__: Descripción del evento, es el contenido principal que podrán leer los demás usuarios.
*	__address__: Dirección o ubicación en dónde se realizará el evento.
*	__start_time__: Fecha y hora en al cual se dará el inicio al evento.
*	__end_time__: fecha y hora en la que terminará el evento.
*	__status__: Estado del evento, este depende de las fechas de inicio y término del evento.
    1.	*Disponible:* significa que el evento se realizará en un futuro o se está realizando.
    2.	*Realizado:* significa que el evento ya se realizó y que fue marcado como realizado.
    3.	*Cancelado:* Significa que el evento fue cancelado, no se elimina, para dejar un registro de él
    4.	*Caducado:* Significa que pasó el tiempo del evento y aún así no se realizó.

**RELACIONES**

*	belongs_to User  
*	has_many Comment como 'post'

=end
class Event < ActiveRecord::Base
	#RELACIONES
	belongs_to :user  
	has_many :comments, as: :post

	#VALIDACIONES
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 20, maximum: 10000} #validar maximos y minimos de caracteres
	validates :address, presence: true #no puede haber carácteres en blanco
	validates :status, presence: true

	#Método que permite que el buscador encuentre Eventos a través de match de palabras en sus atributos.
    def self.search(search)
		where("title LIKE ? or description LIKE ?", "%#{search}%","%#{search}%") 
	end
end
