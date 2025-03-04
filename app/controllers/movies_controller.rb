class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show update destroy] # Run this method before show, update, and destroy actions
  # respond_to :json # Not needed after Ruby 7 +
  # @movies is an instance variable

  # GET /movies
  # Fetches all movies from the database and returns them as a JSON response
  def index
    @movies = Movie.all
    render json: @movies
  end

  # GET /movies/:id
  # Fetches a single movie by its ID
  def show
    render json: @movie
  end

  # POST /movies
  # Creates a new movie record in the database with the given parameters
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created # Return the created movie with status 201
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity # Return validation errors
    end
  end

  # PATCH/PUT /movies/:id
  # Updates an existing movie record with new data
  def update
    if @movie.update(movie_params)
      render json: @movie # Return updated movie
    else
      render json: { errors: @movie.errors.full_messages }, status: :unprocessable_entity # Return validation errors
    end
  end

  # DELETE /movies/:id
  # Deletes a movie from the database
  def destroy
    if @movie.destroy
      render json: { message: "Movie deleted successfully" }, status: :ok # Return success message
    else
      render json: { error: "Failed to delete movie" }, status: :unprocessable_entity # Return error if deletion fails
    end
  end

  private

  # Before executing actions like show, update, or destroy, find the movie by ID
  def set_movie
    @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Movie not found" }, status: :not_found # Handle case where movie ID does not exist
  end

  # Strong parameters to prevent unwanted attributes from being added to the database
  def movie_params
    params.require(:movie).permit(
      :title, :description, :release_year, :director,
      :release_date, :score, :status, :image_url, :trailer_url,
      genres: [] # Ensure genres are stored as an array in the database
    )
  end
end
