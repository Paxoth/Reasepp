=begin Rdoc
_**Question**_ es la entidad que hace referencia a los bloques de preguntas frecuentes que puede agregar los administradores al sitio, para que usuarios, tanto registrados como no puedan leer._

**ATRIBUTOS**
*	__title__: título de la pregunta, hace referencia a la pregunta frecuente en si.
*	__answer__: respuesta de la pregunta frecuente.
*	__reader__: Este atributo es utilizado para marcar si esta pregunta frecuente será enfocada para los usuarios conectados a la intranet o para usuarios desde el sitio web sin conexión.

**RELACIONES:**

	Esta entidad no posee relaciones, ya que no es relevante qué un usuario quede a cargo de la pregunta frecuente.

=end

class Question < ActiveRecord::Base
	#VALIDACIONES:
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :answer, presence: true
	validates :reader, presence: true

	#Método que permite que el buscador encuentre Preguntas Frecuentes a través de match de palabras en sus atributos.	
	def self.search(search)
		where("title LIKE ? or answer LIKE ?", "%#{search}%","%#{search}%") 
	end
end
