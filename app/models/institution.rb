class Institution < ActiveRecord::Base
	#ENTIDAD INSTITUTION:
	#Representa las intituciones que participan de la orgazación de REASE.
	#Los usuarios pueden indicar que pertenecen a una institución específica y del mismo modo las actividades AS
	#tienen una insitución principal que la organiza.

	#ATRIBUTOS:
		#name: Nombre de la institución
		#description: descrición de la institución
		#web: url de la página web de la institución
		#logo: imagen del logotipo de la institución, que será mostrada en la página inicial de quiénes somos.

	#CAMBIOS POR HACER:
		#Se crea una página por institución a modo de perfil de la insitución, con su respectivo encargado AS.
		#Esto con el fin de que en esta página se realicen las modificaciones de información de la insitución y
		#se puden ver información de gestión que pueda ser útil para los miembros de estas.

	
	#RELACIONES
	has_many :users
	has_many :offerings
	has_many :requests
	has_many :services
	has_many :experiences

	#VALIDACIONES
	has_attached_file :logo, styles: {mini:"160x80"}
	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/ 
	validates :name, presence: true, uniqueness: true
	validates :web, presence: true, uniqueness: true

	#Función que permite que el buscador encuentre Instituciones a través de match de palabras en sus atributos.
	def self.search(search)
		where("name LIKE ? or web LIKE ?", "%#{search}%","%#{search}%") 
	end
end
