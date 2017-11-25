# * *ENTIDAD EVENT*	:
#   - Entidad que representa los eventos que se pueden generar en la página de REASE: 
#
# * *Atributos*    :
#   - +Title+ -> the number of apples
#   - +Description+ -> the number of oranges
#   - +Address+ -> the number of pears
#   - +start_time -> Fecha y hora en al cual se dará el inicio al evento
#   - +end_time -> fecha y hora en la que terminará el evento
#   - +Status -> Estado del evento, este depende de las fechas de inicio y término del evento.
#1: Disponible: significa que el evento se realizará en un futuro o se está realizando.
#2: Realizado: significa que el evento ya se realizó y que fue marcado como realizado.
#3: Cancelado: Significa que el evento fue cancelado, no se elimina, para dejar un registro de él
#3: Caducado: Significa que pasó el tiempo del evento y aún así no se realizó.
# * *Returns* :
#   - the total number of fruit as an integer
# * *Raises* :
#   - +ArgumentError+ -> if any value is nil or negative
#	#.
	

class Event < ActiveRecord::Base
	#RELACIONES
	belongs_to :user  
	has_many :comments, as: :post

	#VALIDACIONES
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 20, maximum: 10000} #validar maximos y minimos de caracteres
	validates :address, presence: true #no puede haber carácteres en blanco
	validates :status, presence: true

	#Función que permite que el buscador encuentre Eventos a través de match de palabras en sus atributos.
	def self.search(search)
		where("title LIKE ? or description LIKE ?", "%#{search}%","%#{search}%") 
	end
end
