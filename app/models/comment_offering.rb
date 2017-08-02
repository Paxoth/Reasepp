class CommentOffering < ActiveRecord::Base

	belongs_to :user
	belongs_to :offering
	
end
