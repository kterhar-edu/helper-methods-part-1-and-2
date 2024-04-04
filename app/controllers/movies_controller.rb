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
    @movie = Movie.find(params.fetch(:id))

  end


  def update
    movie_attributes = params.require(:movie).permit(:title, :description)
    @movie = Movie.find(params[:id])
  
    # Update the found movie with the given attributes
    if @movie.update(movie_attributes)
      # The update method internally calls valid? and save if validations pass
      redirect_to movies_url, notice: "Movie updated successfully."
    else
      # If validations fail, the update method will return false
      # You may want to render the edit template to display validation errors
      render :edit, notice: "Movie failed to update successfully."
    end
  end



  def destroy

    @movie = Movie.find(params.fetch(:id))
    @movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
