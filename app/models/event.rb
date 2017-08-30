class Event < ActiveRecord::Base
  belongs_to :user
  
  has_many :comments, as: :post
	#validaciones
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 20, maximum: 10000} #validar maximos y minimos de caracteres
	validates :address, presence: true #no puede haber carácteres en blanco
	validates :status, presence: true

	def self.search(search)
		where("title LIKE ? or description LIKE ?", "%#{search}%","%#{search}%") 
	end
end
