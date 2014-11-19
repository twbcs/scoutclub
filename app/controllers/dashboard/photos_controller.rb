class Dashboard::PhotosController < Dashboard::DashboardController
  def create
    @photo = Photo.new(photo_params)
    @photo.save
    respond_to do |format|
      if @photo.save
        # format.json { render action: 'show', status: :created, location: @upload_photo }
        format.js
      else
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @photo = Photo.where(album_id: params[:album_id], id: params[:id]).first
  end

  def destroy
    @photo = Photo.where(album_id: params[:album_id], id: params[:id]).first
    @photo.remove_file!
    @photo.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:file, :user_id, :album_id, :name)
  end
end
