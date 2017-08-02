class InterestLink < ActiveRecord::Base

	validates :name, presence: true, uniqueness: true
	validates :url, presence: true, uniqueness: true

	def self.search(search)
		where("name LIKE ? or description LIKE ?", "%#{search}%","%#{search}%") 
	end
end
