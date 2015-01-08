class Dashboard::MusicsController < Dashboard::DashboardController
  before_action :is_inside
  before_action :set_music, except: [:index, :new, :create]

  def index
    @musics = Music.all.includes(:user).paginate(page: params[:page], per_page: 20)
  end

  def new
    @music = Music.new
  end

  def create
    @music = Music.new(music_params)
    @music.set_user(current_user.id)
    if @music.save
      redirect_to dashboard_music_path(@music)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @music.update(music_params)
      redirect_to dashboard_music_path(params[:id])
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @music.remove_file!
    @music.destroy
    redirect_to dashboard_musics_path
  end

  private

  def music_params
    params.require(:music).permit(:file, :title, :description, :user_id)
  end

  def set_music
    @music = Music.find(params[:id])
  end
end
