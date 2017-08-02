class CommentOfferingsController < ApplicationController
	before_action :set_comment_offering, only: [:update, :destroy]
	before_action :authenticate_user!
	before_action :set_offering

	# GET /comment_offerings/1/edit
	def edit
	end

	# POST /comment_offerings
	# POST /comment_offerings.json
	def create
	    @comment_offering = current_user.comment_offerings.new(comment_offering_params)
	    @comment_offering.offering = @offering

		respond_to do |format|
			if @comment_offering.save
				format.html { redirect_to @comment_offering.offering , notice: 'Ha comentado la oferta' }
				format.json { render :show, status: :created, location: @comment_offering }
			else
				format.html { render :new }
				format.json { render json: @comment_offering.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /comment_offerings/1
	# PATCH/PUT /comment_offerings/1.json
	def update
		respond_to do |format|
			if @comment_offering.update(comment_offering_params)
				format.html { redirect_to @comment_offering.offering , notice: 'Ha actualizado el comentario' }
				format.json { render :show, status: :ok, location: @comment_offering }
			else
				format.html { render :edit }
				format.json { render json: @comment_offering.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /comment_offerings/1
	# DELETE /comment_offerings/1.json
	def destroy
		@comment_offering.destroy
		respond_to do |format|
			format.html { redirect_to @offering, notice: 'Se ha eliminado el comentario' }
			format.json { head :no_content }
		end
	end

	private
	def set_offering
		@offering = Offering.find(params[:offering_id])
	end
	
	# Use callbacks to share common setup or constraints between actions.
	def set_comment_offering
		@comment_offering = CommentOffering.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def comment_offering_params
		params.require(:comment_offering).permit(:user, :offering, :body)
	end
end
