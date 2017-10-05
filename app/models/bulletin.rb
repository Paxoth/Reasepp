class Bulletin < ActiveRecord::Base
	#ENTIDAD BULLETIN
		#Utilizado para generar los boletines informativos que se pueden enviar a los miembros de REASE
		#indicando las próximas actividades y actualizaciones del sitio
	
	#ATRIBUTOS:
		#title: Título del boletín informativo
		#description: Descripción o cuerpo del boletín, donde se escribe la noticia
		#start_date: Fecha desde la cual se adjuntarán las actualizaciones de la página
		#receiver: Tipo de adhesión de los usuarios que recibirán el boletín a su correo (Activo, adherente, todos) 
		
	#VALIDACIONES
	validates :title, presence: true, uniqueness: true
	validates :description, presence: true
end
