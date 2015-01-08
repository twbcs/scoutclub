class AlbumsController < ApplicationController
  after_action :view_add, only: [:show]
  def index
    @albums = Album.all.includes(:photos)
  end

  def show
    @album = Album.find(params[:id])
    @photos = Photo.where(album_id: params[:id])
  end

  private

  def view_add
    view = Album.find(params[:id])
    view.update_column(:view_count, view.view_count + 1)
  end
end
