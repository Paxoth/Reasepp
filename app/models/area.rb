class Area < ActiveRecord::Base
	
	has_many :requests
	has_many :offerings

end