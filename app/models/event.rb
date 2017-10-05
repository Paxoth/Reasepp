class Event < ActiveRecord::Base
	#ENTIDAD EVENT
	#Entidad que representa los eventos que se pueden generar en la página de REASE.
	
	#ATRIBUTOS:
		#Title: título del evento
		#Description: Descripción del evento, que será lo que podrán leer los usuarios
		#Address: dirección del evento, el cual indicará dónde se realizará
		#start_time: Fecha y hora en al cual se dará el inicio al evento
		#end_time: fecha y hora en la que terminará el evento
		#Status: Estado del evento, este depende de las fechas de inicio y término del evento.
			#1: Disponible: significa que el evento se realizará en un futuro o se está realizando.
			#2: Realizado: significa que el evento ya se realizó y que fue marcado como realizado.
			#3: Cancelado: Significa que el evento fue cancelado, no se elimina, para dejar un registro de él
			#3: Caducado: Significa que pasó el tiempo del evento y aún así no se realizó.

	#RELACIONES
	belongs_to :user  
	has_many :comments, as: :post

	#VALIDACIONES
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 20, maximum: 10000} #validar maximos y minimos de caracteres
	validates :address, presence: true #no puede haber carácteres en blanco
	validates :status, presence: true

	#Función para usar el buscador de eventos de acuerdo algun match entre las palabras y los valores de los atributos de esta.
	def self.search(search)
		where("title LIKE ? or description LIKE ?", "%#{search}%","%#{search}%") 
	end
end
