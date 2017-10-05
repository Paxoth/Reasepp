class Area < ActiveRecord::Base
	#ENTIDAD AREA
	#Representa las Áreas de Trabajo que son establecidas por la organización basadas en la OCDE
	#Las áreas son utilizadas para clasificar las actividades de servicios como ofertas, solicitudes y experiencias.
	
	#ATRIBUTOS:
		#Name: nombre específico del área
		#Discipline: nombre de la disciplina del área
		#Description: pequeña descripción del área
	
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