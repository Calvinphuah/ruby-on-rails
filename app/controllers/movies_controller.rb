class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show update destroy]

  # GET /movies
  def index
    @movies = Movie.all
    render json: @movies
  end

  # GET /movies/:id
  def show
    render json: @movie
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Movie not found" }, status: :not_found
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/:id
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /movies/:id
  def destroy
    if @movie.destroy
      render json: { message: "Movie deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete movie" }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to set the movie for show, update, and delete actions.
  def set_movie
    @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Movie not found" }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def movie_params
    params.require(:movie).permit(:title, :description, :release_year, :director, :release_date, :score, :status, :image_url, genres: [])
  end
  
end
