class ContactMailer < ApplicationMailer
	default from: 'redrease@gmail.com'

	def contact_sender(contact)
		@contact = contact
		mail(to: @contact.email, subject: 'Su comentario ha sido enviado')
	end
	def contact_receiver(contact)
		@contact = contact
		mail(to: 'redrease@gmail.com', subject: 'Nuevo comentario para REASE de '+@contact.name)
	end
end
