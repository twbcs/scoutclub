class Dashboard::Admin::GroupsController < Dashboard::Admin::AdminController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  def index
    @groups = Group.all.includes(:users)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to(dashboard_admin_groups_url, notice: '群組新增完成')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to(dashboard_admin_groups_url, notice: '群組修改完成')
    else
      render :edit
    end
  end

  def show
    @group_forums = GroupForum.where(group_id: params[:id]).joins(:forum)
                    .select('group_forums.id, group_forums.level, forums.title')
  end

  def destroy
    @group.destroy
    redirect_to(dashboard_admin_groups_url, notice: '群組已刪除')
  end

  private

  def group_params
    params.require(:group).permit(:name, :admin)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
