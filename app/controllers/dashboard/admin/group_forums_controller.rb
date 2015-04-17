class Dashboard::Admin::GroupForumsController < Dashboard::Admin::AdminController
  before_action :set_group_forum, only: [:edit, :update, :destroy]
  def new
    @group_forum = GroupForum.new
    @group_forum.group_id = params[:group_id]
    @group = Group.find(params[:group_id])
    forum = GroupForum.find_set do |result, reply|
      result.merge(reply[:id] => reply[:forum_id])
    end
    @forums = forum.values
  end

  def create
    @group_forum = GroupForum.new(group_forum_params)
    if @group_forum.save
      redirect_to dashboard_admin_group_path(@group_forum.group_id), notice: '權限新增完成'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:group_id])
    forum = GroupForum.find_set do |result, reply|
      result.merge(reply[:id] => reply[:forum_id])
    end
    @forums = forum.values - [@group_forum[:forum_id]]
  end

  def update
    if @group_forum.update(group_forum_params)
      redirect_to dashboard_admin_group_path(@group_forum.group_id), notice: '權限修改完成'
    else
      render :edit
    end
  end

  def destroy
    @group_forum.destroy
    redirect_to dashboard_admin_group_path(@group_forum.group_id), notice: '權限已刪除'
  end

  private

  def group_forum_params
    params.require(:group_forum).permit(:group_id, :forum_id, :level)
  end

  def set_group_forum
    @group_forum = GroupForum.find(params[:id])
  end
end
