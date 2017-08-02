class Community < ActiveRecord::Base

	belongs_to :requests
	belongs_to :service_offerings
	
end