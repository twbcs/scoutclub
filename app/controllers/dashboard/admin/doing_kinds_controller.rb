class Dashboard::Admin::DoingKindsController < Dashboard::Admin::AdminController
  before_action :set_doing_kind, only: [:edit, :update, :destroy]

  def index
    @doing_kinds = DoingKind.all
  end

  def new
    @doing_kind = DoingKind.new
  end

  def create
    @doing_kind = DoingKind.new(doing_kind_params)
    if @doing_kind.save
      redirect_to dashboard_admin_doing_kinds_url
    else
      render new
    end
  end

  def edit
  end

  def update
    if @doing_kind.update(doing_kind_params)
      redirect_to dashboard_admin_doing_kinds_url
    else
      render edit
    end
  end

  def destroy
    @doing_kind.destroy
    redirect_to dashboard_admin_doing_kinds_url
  end

  private

  def set_doing_kind
    @doing_kind = DoingKind.find(params[:id])
  end

  def doing_kind_params
    params.require(:doing_kind).permit(:title)
  end
end
