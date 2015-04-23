class PhotosController < ApplicationController
  def show
    @photo = Photo.where(album_id: params[:album_id], id: params[:id]).first
  end
end
