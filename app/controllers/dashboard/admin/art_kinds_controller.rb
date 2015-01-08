class Dashboard::Admin::ArtKindsController < Dashboard::Admin::AdminController
  before_action :set_artkind, only: [:edit, :update, :destroy]

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
  end

  def update
    if @art_kind.update(art_params)
      redirect_to dashboard_admin_art_kinds_url
    else
      render :edit
    end
  end

  def destroy
    @art_kind.destroy
    redirect_to dashboard_admin_art_kinds_url
  end

  private

  def art_params
    params.require(:art_kind).permit(:name)
  end

  def set_artkind
    @art_kind = ArtKind.find(params[:id])
  end
end
