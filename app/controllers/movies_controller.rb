class MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end



  def index
    @movies = Movie.order(created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html do
      end
    end
  end



  def show
    @movie = Movie.find(params.fetch(:id))
  end



  def create
    @movie = Movie.new
    @movie.title = params.fetch("query_title")
    @movie.description = params.fetch("query_description")

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie created successfully."
    else
      render "movies/new"
    end
  end



  def edit
    @movie = Movie.find(params.fetch(:id))

  end


    def update
    the_movie = Movie.find(params.fetch(:id))
    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.valid?
      the_movie.save
      redirect_to movies_url, notice: "Movie updated successfully."

    else
      redirect_to movies_url, notice: "Movie failed to update successfully."

    end
  end



  def destroy

    the_movie = Movie.find(params.fetch(:id))
    the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
