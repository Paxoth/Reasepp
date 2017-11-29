=begin rdoc
_**BulletinMailer**_ es utilizada para la generación de los correos electrónicos con los boletines informativos generados por los administradores de la red.
=end
class BulletinMailer < ApplicationMailer
	default from: 'redrease@gmail.com'

	#Método que envía el correo eléctrónico con los datos necesarios de boletín.
	#
	#*	__Argumentos__ 
	#    * 	user: Usuarios que recibirán los boletines (Ver User)
	#        * Activos
	#        * Adherentes
	#        * Todos
	#    * 	sections: Últimas noticias generadas (Ver Section)
	#    * 	events: Últimos eventos generadas (Ver Event)
	#    * 	offerings: Últimas Ofertas de servicios generadas (Ver Offering)
	#    * 	requests: Últimas Solicitudes de servicios generadas (Ver Request)
	#    * 	services: Últimos Servicios generados (Ver Service)
	#    * 	experiences: Últimas Experiencias generadas (Ver Experience)
	def bulletin(bulletin,user,sections,events,offerings,requests, services, experiences)
		@bulletin = bulletin
		@user = user
		@sections = sections
		@events = events
		@offerings = offerings
		@requests = requests
		@service = services
		@experience = experiences
		returnmail(to: @user.email, subject: 'REASE: '+@bulletin.title)
	end
end

