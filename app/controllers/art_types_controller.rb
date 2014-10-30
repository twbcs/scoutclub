class ArtTypesController < ApplicationController
  def index
    @art_types = ArtType.all
  end

  def new
    @art_type = ArtType.new
  end

  def create
    @art_type = ArtType.new(art_params)

    if @art_type.save
      redirect_to art_types_url
    else
      render :new
    end
  end

  def edit
    @art_type = ArtType.find(params[:id])
  end

  def update
    @art_type = ArtType.find(params[:id])

    if @art_type.update(art_params)
      redirect_to art_types_url
    else
      render :edit
    end
  end

  def destroy
    @art_type = ArtType.find(params[:id])

    @art_type.destroy
  end

  private
  def art_params
    params.require(:art_type).permit(:name)
  end
end
