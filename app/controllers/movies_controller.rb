class MoviesController < ApplicationController
  def index
    @movies = Movie.all.includes(:user).paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @movie = Movie.includes(:user).find(params[:id])
  end
end
