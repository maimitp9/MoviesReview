class MoviesController < ApplicationController
	before_action :set_movie, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index,:show,:search]

	def search
		if params[:search].present?
			@movies = Movie.search(params[:search])
		else
			@movies = Movie.all
		end
	end

	def index
		@movies = Movie.all.order("created_at DESC")
	end

	def new
		@movie = current_user.movies.build
	end

	def create
		@movie = current_user.movies.build(movie_param)
		if @movie.save
			redirect_to @movie
		else
			render 'new'
		end
	end

	def show
		@movie = Movie.find(params[:id])
		@reviews = Review.where(movie_id: @movie.id).order('created_at DESC')

		if @reviews.blank?
			@avg_rating = 0
		else
			@avg_rating = @reviews.average(:rating).round(2)
		end
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		if @movie.update_attributes(movie_param)
			redirect_to @movie
		else
			render 'edit'
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.image = nil
		@movie.destroy
		redirect_to movies_path
	end


	private

	def set_movie
		@movie = Movie.find(params[:id])
	end

	def movie_param
		params.require(:movie).permit(:title,:description,:movie_length,:director,:rating,:image)
	end

end
