class Contact < ActiveRecord::Base
	#ENTIDAD CONTACT
	#Utilizado para generar mensajes de contacto por parte de usuarios no registrados hacia el correo de REASE
	
	#ATRIBUTOS;
		#name: nombre del emisor del mensaje de contacto
		#email: correo electrónico del emisor del mensaje de contacto
		#body: cuerpo del mensaje de contacto
	
	#Validaciones
	validates :name, presence: true
	validates :email, presence: true
	validates :body, presence: true, length: {minimum: 20, maximum: 10000} 
end
