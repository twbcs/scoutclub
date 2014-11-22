class Dashboard::Admin::AlbumsController < Dashboard::Admin::AdminController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  after_action :view_add, only: [:show]
  def index
    @albums = Album.all.includes(:photos)
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to dashboard_admin_album_path(@album.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to dashboard_admin_album_path(@album.id)
    else
      render :edit
    end
  end

  def show
    @photos = Photo.where(album_id: params[:id])
    @photo = Photo.new
  end

  def destroy
    @album.destroy
    redirect_to dashboard_admin_albums_path
  end

  private
  def album_params
    params.require(:album).permit(:title,:description,:add_photo_to,:public_at)
  end

  def set_album
    @album = Album.find(params[:id])
  end

  def view_add
    view = Album.find(params[:id])
    view.update_column(:view_count, view.view_count + 1)
  end
end
