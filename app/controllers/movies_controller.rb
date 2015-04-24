class MoviesController < ApplicationController
  def index
    @movies = Movie.where(public_is: true).includes(:user).page_set(params[:page])
  end

  def show
    @movie = Movie.includes(:user).find(params[:id])
  end
end
