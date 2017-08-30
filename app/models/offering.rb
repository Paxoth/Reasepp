class Offering < ActiveRecord::Base
	belongs_to :user
	belongs_to :community
	belongs_to :area
	belongs_to :institution
	
	has_many :comments, as: :post
	
	has_many :experiences, as: :servicio
	has_many :services, as: :publication
	
	#validaciones
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :description, presence: true, length: {minimum: 27, maximum: 10000} #validar maximos y minimos de caracteres
	validates :status, presence: true
	validates :resume, presence: true, length:{minimum:10, maximum:300}

	def self.search(search)
		where("title LIKE ? or description LIKE ? or resume LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end
