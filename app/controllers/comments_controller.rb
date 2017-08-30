class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comment, only: [:update, :destroy]
	before_action :authenticate_user!

	# GET /comments/1/edit
	def edit
	end

	# POST /comments
	# POST /comments.json
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

	# PATCH/tPUT /comments/1
	# PATCH/PUT /comments/1.json
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

	# DELETE /comments/1
	# DELETE /comments/1.json
	def destroy
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to post_url(post), notice: 'El comentario se ha eliminado' }
			format.json { head :no_content }
		end
	end

	private

		def post
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

		def post_url(post)
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

		def set_comment
			@comment = Comment.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def comment_params
			params.require(:comment).permit(:user_id, :event_id, :offering_id, :request_id, :body, :post_id, :post_type)
		end
end
