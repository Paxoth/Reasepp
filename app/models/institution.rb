class Institution < ActiveRecord::Base
	has_many :users
	has_many :offerings
	has_many :requests
	has_many :services
	has_many :experiences

	has_attached_file :logo, styles: {mini:"160x80"}
	validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/ 
	validates :name, presence: true, uniqueness: true
	validates :web, presence: true, uniqueness: true
	def self.search(search)
		where("name LIKE ? or web LIKE ?", "%#{search}%","%#{search}%") 
	end
end
