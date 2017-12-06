=begin rdoc
_*Area* es la entidad que representa las áreas de trabajo en la cual un proyecto AS está enfocado. Estas áreas de trabajo son las que están definidas por la Organización para la Coordinación del Desarrollo Económico (OCDE)_

**ATRIBUTOS**

*	__Name__: nombre específico del área.
*	__Discipline__: Es la disciplina a la cual el área  de trabajo pertenece (Medicina, Ingeniería, Ciencias Sociales, etc).
*	__Description__: Es la descripción del área de trabajo, la que explica en qué consiste específicamente..

**RELACIONES**

*	has_many Request
*	has_many Offering
*	has_many Service
*	has_many Experience
=end
class Area < ActiveRecord::Base
	#RELACIONES
	has_many :requests
	has_many :offerings
	has_many :services
	has_many :experiences

	#VALIDACIONES
	validates :discipline, presence:true	
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
end