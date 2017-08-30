class Section < ActiveRecord::Base
	belongs_to :user

	#validaciones
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :body, presence: true, length: {minimum: 27, maximum: 10000} #validar maximos y minimos de caracteres
	validates :module, presence: true #no puede haber carácteres en blanco
	validates :priority, presence: true #no puede haber carácteres en blanco

	def self.search(search)
		where("title LIKE ? or body LIKE ? or module LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end