=begin rdoc
_**Comments** Son los comentarios que puede realizar un usuario, en las ofertas de servicios, solicitudes de servicios, servicios activos y eventos._

**ATRIBUTOS**

*	__body__: Corresponde al texto del comentario.
*	__post_id__: Corresponde al id de la publicación cual se está comentado la cual, como ya se mencionó, corresponde a ofertas de servicios, solicitudes de servicios, servicios activos y eventos.
*	__post_type__: Indica qué tipo publicación se está comentando.

**RELACIONES**

*	belongs_to User
*	belongs_to Post (Polimorfismo)
    + Offering
    + Request
    + Service


=end
class Comment < ActiveRecord::Base
	#RELACIONES
	belongs_to :user
	belongs_to :post, polymorphic: true

	#Validaciones
	validates :body, presence: true, length: {minimum: 17, maximum: 150}

end