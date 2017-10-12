class Identity < ActiveRecord::Base

	#Esta entidad fue creada para poder dar paso a la gema Omniauth y permitir la conexión a través de Facebook.
	belongs_to :user
	validates_presence_of :uid, :provider
	validates_uniqueness_of :uid, :scope => :provider

	def self.find_for_oauth(auth)
		find_or_create_by(uid: auth.uid, provider: auth.provider)
	end
end