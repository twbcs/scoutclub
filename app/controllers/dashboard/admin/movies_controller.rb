class Dashboard::Admin::MoviesController < Dashboard::Admin::AdminController
  before_action :set_movie, only: [:edit, :update, :destroy]
  def index
    @movies = Movie.all.includes(:user).paginate(page: params[:page], per_page: 20)
  end

  def show
    @movie = Movie.includes(:user).find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.set_user(current_user.id)
    if @movie.save
      redirect_to dashboard_admin_movie_path(@movie)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to dashboard_admin_movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to dashboard_admin_movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :url, :public_is, :user_id)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
