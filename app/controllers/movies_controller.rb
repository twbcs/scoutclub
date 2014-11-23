class MoviesController < ApplicationController
  def index
    @movies = Movie.where(public_is: true).includes(:user)
              .paginate(:page => params[:page], :per_page => 20)
  end

  def show
    @movie = Movie.includes(:user).find(params[:id])
  end
end
