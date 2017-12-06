=begin rdoc
_**Contact** es la entidad utilizada para generar mensajes de contacto por parte de usuarios no registrados hacia el correo de REASE_

**ATRIBUTOS**

*	__name__: nombre del emisor del mensaje de contacto
*	__email__: correo electrónico del emisor del mensaje de contacto
*	__body__: cuerpo del mensaje de contacto

**RELACIONES**

_Esta entidad no posee relación ya que no posee la necesidad de conectarse con ninguna otra entidad, por su forma externa de uso._
=end
class Contact < ActiveRecord::Base
	#Validaciones
	validates :name, presence: true
	validates :email, presence: true
	validates :body, presence: true, length: {minimum: 20, maximum: 10000} 
end
