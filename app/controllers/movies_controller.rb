class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new
  end

  def index
    matching_movies = Movie.all

    @movies = matching_movies.order(created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
        render "movies/index"
      end
    end
  end

  def show
    @movie = Movie.find(params.fetch(:id))
  end

  def create
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.new(movie_attributes)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "movies/new"
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where(id: the_id)

    @the_movie = matching_movies.first

  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where(id: the_id ).first

    
    attr = params.require(:movie).permit(:title, :description)
    the_movie.title = attr.fetch(:title)
    the_movie.description = attr.fetch(:description)
    if the_movie.valid?
      the_movie.save
      redirect_to movie_url(the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(the_movie), alert: "Movie failed to update successfully."
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where(id: the_id).first

    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
