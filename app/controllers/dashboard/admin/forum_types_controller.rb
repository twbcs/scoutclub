class Dashboard::Admin::ForumTypesController < Dashboard::Admin::AdminController
  before_action :set_forum_type, only: [:edit, :update, :destroy]
  def index
    @forum_types = ForumType.all
    @forums = Forum.all.order_by_forum_type
  end

  def new
    @forum_type = ForumType.new
  end

  def create
    @forum_type = ForumType.new(forum_type_params)
    if @forum_type.save
      redirect_to dashboard_admin_forum_types_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @forum_type.update(forum_type_params)
      redirect_to dashboard_admin_forum_types_url
    else
      render :edit
    end
  end

  def destroy
    @forum_type = ForumType.find(params[:id])
    @forum_type.destroy
    redirect_to dashboard_admin_forum_types_url
  end

  private
  def set_forum_type
    @forum_type = ForumType.find(params[:id])
  end

  def forum_type_params
    params.require(:forum_type).permit(:title, :description)
  end
end
