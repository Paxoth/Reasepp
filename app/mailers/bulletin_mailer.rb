class BulletinMailer < ApplicationMailer
	default from: 'redrease@gmail.com'

	def bulletin(bulletin,user,sections,events,offerings,requests, services, experiences)
		@bulletin = bulletin
		@user = user
		@sections = sections
		@events = events
		@offerings = offerings
		@requests = requests
		@service = services
		@experience = experiences
		mail(to: @user.email, subject: 'REASE: '+@bulletin.title)
	end
end

