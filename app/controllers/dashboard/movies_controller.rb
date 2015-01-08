class Dashboard::MoviesController < Dashboard::DashboardController
  before_action :set_movie, only: [:edit, :update]
  before_action :is_inside, except: [:index, :show]
  def index
    @movies = Movie.all.includes(:user)
              .paginate(page: params[:page], per_page: 20)
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
      redirect_to dashboard_movie_path(@movie)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to dashboard_movie_path(@movie)
    else
      render :edit
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :url, :public_is, :user_id)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end
