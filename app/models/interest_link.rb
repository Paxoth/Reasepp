class InterestLink < ActiveRecord::Base
	#ENTIDAD INTEREST LINK
	#representan links de interés que son relevantes para la institución, los cuales son mostrados en lá página principal.

	#ATRIBUTOS:
		#name: nombre del enlace que será mostrado en la página principal
		#url: dirección del enlace para ser dirigido
		#description: descripción del enlace

	#VALIDACIONES
	validates :name, presence: true, uniqueness: true
	validates :url, presence: true, uniqueness: true

	#Función para usar el buscador de link de interés de acuerdo algun match entre las palabras y los valores de los atributos de esta.
	def self.search(search)
		where("name LIKE ? or description LIKE ?", "%#{search}%","%#{search}%") 
	end
end
