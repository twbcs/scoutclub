class Dashboard::Admin::ForumKindsController < Dashboard::Admin::AdminController
  before_action :set_forum_kind, only: [:edit, :update, :destroy]
  def index
    @forum_kinds = ForumKind.all
    @forums = Forum.all.order_by_forum_kind
  end

  def new
    @forum_kind = ForumKind.new
  end

  def create
    @forum_kind = ForumKind.new(forum_kind_params)
    if @forum_kind.save
      redirect_to dashboard_admin_forum_kinds_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @forum_kind.update(forum_kind_params)
      redirect_to dashboard_admin_forum_kinds_url
    else
      render :edit
    end
  end

  def destroy
    @forum_kind = ForumKind.find(params[:id])
    @forum_kind.destroy
    redirect_to dashboard_admin_forum_kinds_url
  end

  private
  def set_forum_kind
    @forum_kind = ForumKind.find(params[:id])
  end

  def forum_kind_params
    params.require(:forum_kind).permit(:title, :description)
  end
end
