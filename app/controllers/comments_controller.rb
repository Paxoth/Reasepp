=begin rdoc
  _**Comment:** controlador de los comentarios (Ver Comment)_

  _Los comentarios se encuentran anidados a otra publicación (Nested Resources)_
=end
class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment, only: [:update, :destroy]
	before_action :authenticate_user!

	#Método generada por scaffold, no utilizado
	def edit
	end

	# Crear comentario
	#
	# Genera un comentario y te redirecciona al sitio del la publicacion que fue comentada.
	def create
		@post = post
		@comment = @post.comments.create(comment_params)
		@comment.user = current_user
		respond_to do |format|
			if @comment.save
				format.html { redirect_to post_url(post), notice: 'Ha agregado un comentario' }
				format.json { render :show, status: :created, location: @comment }
			else
				format.html { redirect_to post_url(post), alert: 'Recuerde que el comentario debe tener entre 10 y 150 caracteres.' }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	#Editar comentario
	#Permite al usuario editar un comentario con los parametros establecidos.
	def update
		respond_to do |format|
			@post = post
			@comment = @post.comments.create(comment_params)
			if @comment.update(comment_params)
				format.html { redirect_to post_url(post), notice: 'Comentario ha sido actualizado correctamente' }
				format.json { render :show, status: :ok, location: @comment }
			else
				format.html { render :edit }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	# Eliminar comentario y te redirecciona al post donde fue realizado.
	def destroy
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_url(post), notice: 'El comentario se ha eliminado' }
			format.json { head :no_content }
		end
	end

	private
		#Post hace referencia al elemento en donde se generará el comentario
		#
		#*	Event
		#*	Request
		#*	Offering
		#*	Service
		def post # :doc:
			if params[:event_id]
				id = params[:event_id]
				Event.find(params[:event_id])
			elsif params[:request_id]
				id = params[:request_id]
				Request.find(params[:request_id])			
			elsif params[:offering_id]
				id = params[:offering_id]
				Offering.find(params[:offering_id])
			else
				id = params[:service_id]
				Service.find(params[:service_id])
			end
		end 

		#Post_URL hace referencia a la dirección en donde se generará el comentario
		#
		#*	Event
		#*	Request
		#*	Offering
		#*	Service
		def post_url(post) # :doc:
			if Event === post
				event_path(post)
			elsif Request === post
				request_path(post)			
			elsif Offering === post
				offering_path(post)
			else
				service_path(post)
			end
		end

		#Permite la consulta específica de un comentario
		#Poco utilizado, ya que el comentario se desplega en otras vistas
		def set_comment # :doc:
			@comment = Comment.find(params[:id]) 
		end

		#Parametros permitidos para creación un comentario.
		def comment_params 
			params.require(:comment).permit(:user_id, :event_id, :offering_id, :request_id, :body, :post_id, :post_type)
		end
end
