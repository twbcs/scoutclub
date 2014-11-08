class Dashboard::Admin::ArtKindsController < Dashboard::Admin::AdminController
  def index
    @art_kinds = ArtKind.all
  end

  def new
    @art_kind = ArtKind.new
  end

  def create
    @art_kind = ArtKind.new(art_params)

    if @art_kind.save
      redirect_to dashboard_admin_art_kinds_url
    else
      render :new
    end
  end

  def edit
    @art_kind = ArtKind.find(params[:id])
  end

  def update
    @art_kind = ArtKind.find(params[:id])

    if @art_kind.update(art_params)
      redirect_to dashboard_admin_art_kinds_url
    else
      render :edit
    end
  end

  def destroy
    @art_kind = ArtKind.find(params[:id])
    @art_kind.destroy
    redirect_to dashboard_admin_art_kinds_url
  end

  private
  def art_params
    params.require(:art_kind).permit(:name)
  end
end
