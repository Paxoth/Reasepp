class BulletinMailer < ApplicationMailer
	default from: 'coordinacion.rease@gmail.com'

	def bulletin(bulletin,user,sections,events,offerings,requests)
		@bulletin = bulletin
		@user = user
		@sections = sections
		@events = events
		@offerings = offerings
		@requests = requests
		mail(to: @user.email, subject: 'REASE: '+@bulletin.title)
	end
end

