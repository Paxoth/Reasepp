class Comment < ActiveRecord::Base
	#ENTIDAD COMMENT:
	#Utilizado para generar comentario en diferentes post (Servicios y eventos)
		
	#ATRIBUTOS:
		#body: representa el cuerpo del comentario en si
		#post_id: hace referencia al post que se está cometnando (Servicios o eventos)
		#post_type: hace referencia al tipo de post al cual e le hace comentario (request, offerings, experiences, events, etc)
			#Los dos atributos anteriores son referencias basadas en el polimorfismo de los post.
	
	#RELACIONES
	belongs_to :user
	belongs_to :post, polymorphic: true

	#Validaciones
	validates :body, presence: true, length: {minimum: 17, maximum: 150}

end