=begin rdoc

_**Identity**__ esta entidad fue creada para poder dar paso a la gema Omniauth y permitir la conexión a través de Facebook.

**RELACIONES**

*	belongs_to User
=end
class Identity < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :uid, :provider
	validates_uniqueness_of :uid, :scope => :provider

	def self.find_for_oauth(auth) # :nodoc:
		find_or_create_by(uid: auth.uid, provider: auth.provider)
	end
end