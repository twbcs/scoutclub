class Dashboard::Admin::GroupForumsController < Dashboard::Admin::AdminController
  def new
    @group_forum = GroupForum.new
    @group_forum.group_id = params[:group_id]
    @group = Group.find(params[:group_id])
  end

  def create
    @group_forum = GroupForum.new(gf_params)
    if @group_forum.save
      redirect_to dashboard_admin_group_path(@group_forum.group_id), notice: '權限新增完成'
    else
      render :new
    end
  end

  def edit
    @group_forum = GroupForum.find(params[:id])
    @group = Group.find(params[:group_id])
  end

  def update
    @group_forum = GroupForum.find(params[:id])
    if @group_forum.update(gf_params)
      redirect_to dashboard_admin_group_path(@group_forum.group_id), notice: '權限修改完成'
    else
      render :edit
    end
  end

  def destroy
    @group_forum = GroupForum.find(params[:id])
    @group_forum.destroy
    redirect_to dashboard_admin_group_path(@group_forum.group_id), notice: '權限已刪除'
  end

  private
  def gf_params
    params.require(:group_forum).permit(:group_id, :forum_id, :level)
  end
end
