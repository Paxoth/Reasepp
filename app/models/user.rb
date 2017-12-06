=begin rdoc
_**User** es la entidad principal de toda la intranet, representando al usuario registrado en el sitio, el cual tiene ciertos privilegios dependiendo de su categoría, la cual le dará forma al sitio para poder ser poblado por los miembros de REASE._

**ATRIBUTOS**

_User posee muchos atributos generados por la gema Devise, que permite hacer la autenticación con correo electrónico, confirmación y varias consultas útiles para el desarrollo de la plataforma_

*	__email__: Correo electrónico del usuario.
*	__encrypted_password__: Contraseña personal y encriptada del usuario, Esta se encuentra encripatada con el fin de que su lectura no sea permitida.
*	__reset_password_token__: Atributo el cuál es utilizado para recuperar la contraseña vía mail en caso de que el usuario la olvide.
*	__reset_password_sent_at__: Fecha en la cual se envía el mail de recuperación de contraseña.
*	__remember_created_at__: Atributo que permite al sitio recordar los datos del usuario para mantenerse conectado.
*	__sign_in_count__: Contador de la cantidad de veces que el usuario se ha conectado a la intranet.
*	__current_sign_in_at__: Fecha de la conexión actual del usuario.
*	__last_sign_in_at__: fecha de la última vez que el usuario se conectó a la intranet.  
*	__confirmation_token__: Información necesaria para qe el usuario confirme su nueva cuenta vía correo electrónico.
*	__confirmed_at__:  Fecha en la cual el usuario fue confirmado para su registro.
*	__confirmation_sent_at__: Fecha en la cual se envió el correo de confirmación de registro del usuario.
*	__unconfirmed_email__: Indica si el usuario confirmó su registro vía correo electrónico impidiendo su conección en caso de no estar confirmado.
*	__name__: Nombre del usuario.
*	__autorization_level__: Tipo de usuario
    + Activo
    + Adherente
*	__category__: Categoría o rol del usuario 
    2. Profesor: capaz de crear Ofertas de Servicio (Ver Offering). Responsable de los servicios ( Service ) y experiencias ( Experience ).
    3. Socio Comunitario: capaz de crear Solicitudes de Servicio (Ver Request)
    4. Vinculador Social: capaz de crear Ofertas y Solicitudes. No se hace responsable de ellas.
*   __is_admin__: Booleano que permite saber si el usuario es administrador del sitio REASE. Capaz de generar eventos ( Event )
*	__nickname__: Apodo del usuario, el cuál sirve para referirse a él en comentarios y publicaciones.
*	__photo__: Foto de perfil del usuario, la cual se desplegará en cada comentario y facilita la identificación para el resto de los usarios.
*	__description__: Breve descripción del usuario que escribe de sí mismo, en caso de querer hacerlo, la cual será desplegada en su perfil.
*	__Twitter, Facebook, Instagram, Linkedin y Youtube__: Atributos que hacen referencias a las redes sociales que pueda poseer el usuario.

**RELACIONES**

*   belongs_to Institution
*   has_many Section
*   has_many Event
*   has_many Comment
*   has_many Offering
*   has_many Request
*   has_many Experience
*   has_many Project
*   has_many accepted_services ( Service )
*   has_many created_services  ( Service ) 
*   has_many taught_experiences ( Experience )
*   has_many cooperated_experiences  ( Experience )
*   has_many Questions
*   has_many InterestLink
*   has_many Resource
*   has_many Bulletin
=end
class User < ActiveRecord::Base
	#Correo temporal en caso de su creación sin declaración de uno particula. No utilizado comúnmente.
	TEMP_EMAIL_PREFIX = 'change@me'
	#Correo temporal en caso de su creación sin declaración de uno particula. No utilizado comúnmente.
  	TEMP_EMAIL_REGEX = /\Achange@me/
	devise :database_authenticatable, :registerable, :omniauthable,
		:recoverable, :rememberable, :trackable, :validatable, :confirmable

	#RELACIONES
	belongs_to :institution
	
	has_many :sections
	has_many :events
	has_many :comments
	has_many :offerings
	has_many :requests
	has_many :experiences
	has_many :projects
	has_many :questions
	has_many :interest_links
	has_many :resources
	has_many :bulletins

	has_many :accepted_services,:class_name => "Service"
	has_many :created_services, :class_name => "Service"

	has_many :taught_experiences,:class_name => "Experience"
	has_many :cooperated_experiences, :class_name => "Experience"


	has_attached_file :photo, styles: {mini:"30x30", medium: "500x200", thumb:"700x300"}, :default_url => ":style/missingPhoto.png"
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

	validates :name, presence: true, length:{maximum:50}
	validates :nickname, length:{maximum:14}
	validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

	#Método que permite que el buscador encuentre Usuarios a través de match de palabras en sus atributos.
	def self.search(search)
		where("nickname LIKE ? or name LIKE ? or email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
	
	#Método que permite la autentificación del usuario para ingreso de la intranet, buscando información del correo electrónico del usuario.
	#Método generado por la gema Devise
	def self.find_for_oauth(auth, signed_in_resource = nil)

		# Get the identity and user if they exist
		identity = Identity.find_for_oauth(auth)

		# If a signed_in_resource is provided it always overrides the existing user
		# to prevent the identity being locked with accidentally created accounts.
		# Note that this may leave zombie accounts (with no associated identity) which
		# can be cleaned up at a later date.
		user = signed_in_resource ? signed_in_resource : identity.user

		# Create the user if needed
		if user.nil?

			# Get the existing user by email if the provider gives us a verified email.
			# If no verified email was provided we assign a temporary email and ask the
			# user to verify it on the next step via UsersController.finish_signup
			email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
			email = auth.info.email if email_is_verified
			user = User.where(:email => email).first if email

			# Create the user if it's a new registration
			if user.nil?
				user = User.new(
					name: auth.extra.raw_info.name,
					#username: auth.info.nickname || auth.uid,
					email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
					password: Devise.friendly_token[0,20]
				)
				user.skip_confirmation!
				user.save!
			end
		end

		# Associate the identity with the user if needed
		if identity.user != user
			identity.user = user
			identity.save!
		end
		user
	end

	#Método que verifica si su correo electrónico fue confirmado a través del token de confirmación. Analiza que su correo no sea el por default.
	def email_verified?
		self.email && self.email !~ TEMP_EMAIL_REGEX
	end
end
