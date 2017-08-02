class CommentRequestsController < ApplicationController
	before_action :set_comment_request, only: [:update, :destroy]
	before_action :authenticate_user!
	before_action :set_request

	# GET /comment_requests/1/edit
	def edit
	end

	# POST /comment_requests
	# POST /comment_requests.json
	def create
	    @comment_request = current_user.comment_requests.new(comment_request_params)
	    @comment_request.request = @request

		respond_to do |format|
			if @comment_request.save
				format.html { redirect_to @comment_request.request , notice: 'Ha comentado la solicitud' }
				format.json { render :show, status: :created, location: @comment_request }
			else
				format.html { render :new }
				format.json { render json: @comment_request.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /comment_requests/1
	# PATCH/PUT /comment_requests/1.json
	def update
		respond_to do |format|
			if @comment_request.update(comment_request_params)
				format.html { redirect_to @comment_request.request , notice: 'Ha actualizado el comentario' }
				format.json { render :show, status: :ok, location: @comment_request }
			else
				format.html { render :edit }
				format.json { render json: @comment_request.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /comment_requests/1
	# DELETE /comment_requests/1.json
	def destroy
		@comment_request.destroy
		respond_to do |format|
			format.html { redirect_to @request, notice: 'Se ha eliminado el comentario' }
			format.json { head :no_content }
		end
	end

	private
	def set_request
		@request = Request.find(params[:request_id])
	end
	
	# Use callbacks to share common setup or constraints between actions.
	def set_comment_request
		@comment_request = CommentRequest.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def comment_request_params
		params.require(:comment_request).permit(:user, :request, :body)
	end
end
