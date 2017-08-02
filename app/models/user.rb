class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
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

	has_and_belongs_to_many :messages

	has_attached_file :photo, 
			:styles => {mini:"30x30", medium:"700x300", thumb:"800x600"},
			:default_url => "/images/:style/missingPhoto.png"
	validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/
	validates :nickname, uniqueness: true, format: { without: /\s/ }, length: {minimum: 3, maximum: 14} #no se pueden repertir los nick

	def self.search(search)
		where("nickname LIKE ? or name LIKE ? or last_name LIKE ? or email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end
