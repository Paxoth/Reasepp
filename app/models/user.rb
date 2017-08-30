class User < ActiveRecord::Base
	 TEMP_EMAIL_PREFIX = 'change@me'
  	TEMP_EMAIL_REGEX = /\Achange@me/
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :omniauthable,
		:recoverable, :rememberable, :trackable, :validatable, :confirmable

	belongs_to :institution
	
	has_many :sections
	has_many :events
	has_many :comments
	has_many :offerings
	has_many :comment_offerings
	has_many :requests
	has_many :comment_requests
	has_many :meetings
	has_many :experiences
	has_many :projects

	has_many :accepted_services,:class_name => "Service"
	has_many :created_services, :class_name => "Service"

	has_many :taught_experiences,:class_name => "Experience"
	has_many :cooperated_experiences, :class_name => "Experience"

	has_and_belongs_to_many :messages

	has_attached_file :photo, styles: {mini:"30x30", medium: "500x200", thumb:"700x300"}, :default_url => ":style/missingPhoto.png"
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

	validates :name, presence: true, length:{maximum:50}
	validates :nickname, length:{maximum:14}
	

	def self.search(search)
		where("nickname LIKE ? or name LIKE ? or email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
	validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

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

	def email_verified?
	self.email && self.email !~ TEMP_EMAIL_REGEX
	end
end
