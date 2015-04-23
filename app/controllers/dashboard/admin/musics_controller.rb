class Dashboard::Admin::MusicsController < Dashboard::Admin::AdminController
  before_action :set_music, only: [:show, :edit, :update, :destroy]

  def index
    @musics = Music.all.page_set
  end

  def new
    @music = Music.new
  end

  def create
    @music = Music.new(music_params)
    @music.setup_user(current_user.id)
    if @music.save
      redirect_to dashboard_admin_music_path(@music)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @music.update(music_params)
      redirect_to dashboard_admin_music_path(params[:id])
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @music.remove_file!
    @music.destroy
    redirect_to dashboard_admin_musics_path
  end

  private

  def music_params
    params.require(:music).permit(:file, :title, :description, :user_id)
  end

  def set_music
    @music = Music.find(params[:id])
  end
end
