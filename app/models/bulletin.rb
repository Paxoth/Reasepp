=begin rdoc
_**Bulletin** es la entidad que representa los boletines informativos. Estos son los boletines que los administradores pueden enviar vía correo electrónico a los demás usuarios. Siendo estos boletines capaces de contener las últimas actualizaciones realizadas en la intranet._

**ATRIBUTOS**

*	__title__: Título del boletín.
*	__description__: Descripción del boletín que es el cuerpo principal del mail que se envía.
*	__start_date__: Fecha desde la cual se tomarán las actualizaciones de la página para ser adjuntadas en el mail que se envía.
*	__receiver__: Opción para decidir qué tipo de usuario recibirá el boletín.

**RELACIONES**

*   belongs_to User
=end

class Bulletin < ActiveRecord::Base

	#RELACIONES
	belongs_to :user

	#VALIDACIONES
	validates :title, presence: true, uniqueness: true
	validates :description, presence: true
end
