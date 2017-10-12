class Resource < ActiveRecord::Base
	#ENTIDAD RESOURCE
	#Entidad que hace referencia a los Recursos que posee el sitio web, los cuales pueden ser PDF, imágenes, docuementos de office, etc.

	#ATRIBUTOS
		#name: Nombre del recurso
		#date: fecha del recurso. Si es un acta tendrá la fecha de cuando se realizó la asamblea.
		#archive: Es el archivo adjunto que contendrá, el cuál puede ser descargado.
		#category: clasificaciones posibles para diferentes recursos
			#1: Acta de reunión
			#2: Plantilla de recursos
			#3: Formación AS
			#4: Enlaces útiles
			#5: Otros
		#description: Descripción del recurso.

	#RELACIONES

	#VALIDACIONES
	has_attached_file :archive
	validates_attachment_content_type :archive, 
	:content_type => ['application/pdf','image/jpg','image/jpeg','image/pjpeg','image/png','image/x-png','image/gif','application/msword','application/vnd.openxmlformats-officedocument.wordprocessingml.document','application/msexcel','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/mspowerpoint','application/vnd.ms-powerpoint','application/vnd.openxmlformats-officedocument.presentationml.presentation']
	validates :name, presence: true, uniqueness: true
	validates :description, presence: true
	validates :category, presence: true
	validates :date, presence: true
	
	#Función que permite que el buscador encuentre Recursos a través de match de palabras en sus atributos.
	def self.search(search)
		where("name LIKE ? or category LIKE ? or description LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end

