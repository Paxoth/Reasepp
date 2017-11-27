=begin rdoc
_**Institituion**  es la entidad representa las instituciones que están adheridas a REASE, las cuales servirán para indicar si algún servicio está relacionado con él y del mismo modo si un usuario pertenece a alguna de estas instituciones._
_Las instituciones fueron modificadas ahora para que los encargados AS puedan obtener información para la gestión, como datos de cuántas experiencias se han realizado dentro de un intervalo de tiempo_

**ATRIBUTOS**

*	__description__: Breve descripción de la institución. El encargado AS, debe ser responsable de completar este campo.
*	__name__: Nombre de la institución.
*	__web__: Sitio web que pertenece a la institución. El encargado AS, debe ser responsable de completar este campo.
*	__logo__: Logotipo de la institución. El encargado AS, debe ser responsable de completar este campo.
*	__manager_id__: id del usuario que representa al encargado AS.

**RELACIONES**

*	belongs_to User : Usuario creador de la institución (Admin)
*	has_many User : Usuarios que pertenecen a la institución.
*	has_many Offering
*	has_many Request
*	has_many Service
*	has_many Experience
=end

class Institution < ActiveRecord::Base
	#RELACIONES
	belongs_to :user #referencia al usuario que lo crea.
	has_many :users #referencia a los usuarios que pertenece a la institución
	has_many :offerings
	has_many :requests
	has_many :services
	has_many :experiences

	#VALIDACIONES
	has_attached_file :logo, styles: {mini:"160x80"}
	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/ 
	validates :name, presence: true, uniqueness: true

	
	
	#Método que permite que el buscador encuentre Instituciones a través de match de palabras en sus atributos.
	def self.search(search)
		where("name LIKE ? or web LIKE ?", "%#{search}%","%#{search}%") 
	end
end
