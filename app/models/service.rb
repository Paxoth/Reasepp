class Service < ActiveRecord::Base
	belongs_to :creator, :class_name=> "User"
	belongs_to :acceptor, :class_name=> "User"
	
	belongs_to :area
	belongs_to :institution
	belongs_to :publication, polymorphic: true

	has_many :experiences
	has_many :comments, as: :post

	def self.search(search)
		where("title LIKE ? or message LIKE ? or description LIKE ? or resume LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end