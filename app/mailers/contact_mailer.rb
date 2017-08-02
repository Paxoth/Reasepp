class ContactMailer < ApplicationMailer
	default from: 'coordinacion.rease@gmail.com'

	def contact_sender(contact)
		@contact = contact
		mail(to: @contact.email, subject: 'Su comentario ha sido enviado')
	end
	def contact_receiver(contact)
		@contact = contact
		mail(to: 'coordinacion.rease@gmail.com', subject: 'Nuevo comentario para REASE de '+@contact.name)
	end
end
