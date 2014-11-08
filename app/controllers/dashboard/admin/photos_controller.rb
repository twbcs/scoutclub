class Dashboard::Admin::PhotosController < Dashboard::Admin::AdminController

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.save
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Upload photo was successfully created.' }
        # format.json { render action: 'show', status: :created, location: @upload_photo }
        format.json { render json: {files: [@photo.to_jq_upload]}, status: :created, location: @photo }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:file, :user_id, :album_id, :name)
  end
end
