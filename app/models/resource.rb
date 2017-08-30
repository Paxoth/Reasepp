class Resource < ActiveRecord::Base

	has_attached_file :archive
	validates_attachment_content_type :archive, 
	:content_type => ['application/pdf','image/jpg','image/jpeg','image/pjpeg','image/png','image/x-png','image/gif','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document','application/msexcel','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/mspowerpoint','application/vnd.ms-powerpoint','application/vnd.openxmlformats-officedocument.presentationml.presentation']
	

	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
	validates :category, presence: true
	validates :date, presence: true
	def self.search(search)
		where("name LIKE ? or category LIKE ? or description LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end
