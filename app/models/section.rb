=begin rdoc
_**Section** es la entidad principal del portal web REASE. Fue creada para la clasificación de los diferentes publicaciones que pueden realizar los administradores del sitio, las cuales se desplegarán de manera ordenada en el sitio web._

**ATRIBUTOS**

*	__title__: Título de la publicación.
*	__module__: módulo o clasificación de las publicaciones que representan las secciones.
    + Novedad: clasificación para las noticias presentadas en la página principal. 
    + Aprendizaje Servicio: clasificación para la página de ¿Qué es el aprendizaje y servicio?
    + Hacemos: clasificación para el módulo de ¿Qué hacemos?
    + Somos: clasificación para el módulo de ¿Quiénes somos?
    + Estatuto: clasificación para el módulo del estatuto, en donde se pueden publicar los árticulos de este.
*	__body__: Contenido o cuerpo de la publicación.
*	__priority__: Prioridad de la publicación para dar un orden de estas.

**RELACIONES**

*	belongs_to User	
=end
class Section < ActiveRecord::Base
	#RELACIONES
	belongs_to :user

	#VALIDACIONES
	validates :title, presence: true, uniqueness: true #no pueden haber dos titulos iguales
	validates :body, presence: true, length: {minimum: 27, maximum: 10000} #validar maximos y minimos de caracteres
	validates :module, presence: true #no puede haber carácteres en blanco
	validates :priority, presence: true #no puede haber carácteres en blanco

	#Método que permite que el buscador encuentre Secciones a través de match de palabras en sus atributos.
	def self.search(search)
		where("title LIKE ? or body LIKE ? or module LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
	end
end