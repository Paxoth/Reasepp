class Question < ActiveRecord::Base

	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :answer, presence: true
	validates :reader, presence: true

	def self.search(search)
		where("title LIKE ? or answer LIKE ?", "%#{search}%","%#{search}%") 
	end
end
