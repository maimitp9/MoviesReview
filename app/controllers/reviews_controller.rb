class ReviewsController < ApplicationController
	before_action :set_review, only: [:destroy,:edit]
	before_action :set_movie
	before_action :authenticate_user!
	def new
		@review = Review.new
	end

	def create
		@review = Review.new(review_param)
		@review.user_id = current_user.id
		@review.movie_id = @movie.id

		if @review.save
			redirect_to @movie
		else
			render 'new'
		end
	end

	private

	def set_review
		@review = Review.find(params[:id])
	end

	def set_movie
		@movie = Movie.find(params[:movie_id])
	end

	def review_param
		params.require(:review).permit(:rating, :comment)
	end
end
