class MoviesController < ApplicationController
  def index
    @movies = Movie.where(public_is: true).page_set
  end

  def show
    @movie = Movie.includes(:user).find(params[:id])
  end
end
