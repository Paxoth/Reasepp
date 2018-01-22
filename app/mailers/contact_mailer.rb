=begin rdoc
_**ContactMailer** es utilizado para la generación de correos electrónicos de la página contacto del portal web de REASE._ 
=end
class ContactMailer < ApplicationMailer
	default from: 'coordinacion.rease@gmail.com'

	#Método que envía un correo electrónico al ususario que se intentó contactar.
	#
	#*	__Argumentos__ 
	#    * 	contact: datos del contacto enviado a través del formulario de la página de contacto (Ver Contact)
	def contact_sender(contact)
		@contact = contact
		mail(to: @contact.email, subject: 'Su comentario ha sido enviado')
	end

	#Método que envía un correo electrónico al correo electrónico de REASE.
	#
	#*	__Argumentos__ 
	#    * 	contact: datos del contacto enviado a través del formulario de la página de contacto (Ver Contact)
	def contact_receiver(contact)
		@contact = contact
		mail(to: 'coordinacion.rease@gmail.com', subject: 'Nuevo comentario para REASE de '+@contact.name)
	end
end
