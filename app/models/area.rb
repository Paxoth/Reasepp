class Area < ActiveRecord::Base
	
	has_many :requests
	has_many :offerings
	has_many :services
	has_many :experiences

	validates :discipline, presence:true	
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
end