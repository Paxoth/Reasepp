class Project < ActiveRecord::Base
	belongs_to :area
	belongs_to :user
	belongs_to :institution

	def self.search(search)
		where("faculty LIKE ? or department LIKE ? or course_name LIKE ? or course_type LIKE ? or period LIKE ? or learning_objectives LIKE ? or service_objectives LIKE ? or benefit LIKE ? or results LIKE ? or tools LIKE ? or description LIKE ? or reflection_moments LIKE ? or title LIKE ?", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%" , "%#{search}%") 
	end
end
