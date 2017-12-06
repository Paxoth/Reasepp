=begin rdoc
_**Interest Link** es la entidad que representa los links de interés que se despliegan a lo largo de  la intranet, que contienen información relacionada al Aprendizaje Servicio._

**ATRIBUTOS**

*	__name__: Nombre del sitio al cual redirecciona.
*	__url__: Dirección del sitio al cual redirecciona.
*	__description__: Breve descripción del sitio al cual redirecciona.

**RELACIONES**

*   belongs_to User
=end

class InterestLink < ActiveRecord::Base

	#RELACIONES
	belongs_to :user

	#VALIDACIONES
	validates :name, presence: true, uniqueness: true
	validates :url, presence: true, uniqueness: true

	#Método que permite que el buscador encuentre Enlaces de Interés a través de match de palabras en sus atributos.
	def self.search(search)
		where("name LIKE ? or description LIKE ?", "%#{search}%","%#{search}%") 
	end
end
