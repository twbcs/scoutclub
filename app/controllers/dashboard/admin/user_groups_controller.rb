class Dashboard::Admin::UserGroupsController < Dashboard::Admin::AdminController
  def index
    @user_rule = Modify.find_by(user_id: current_user)
    @user_groups = User.all.includes(:groups) #.order('groups.group_id')res
  end

  def new
    @user_group = UserGroup.new
    @user_group.user_id = params[:user_id]
  end

  def create
    @user_group = UserGroup.new(user_group_params)
    if @user_group.save
      redirect_to dashboard_admin_user_groups_path
    else
      render :new
    end
  end

  def edit
    @user_group = UserGroup.find_by(user_id: params[:user_id], group_id: params[:group_id])
  end

  def update
    @user_group = UserGroup.find(params[:id])
    if @user_group.update(user_group_params)
      redirect_to dashboard_admin_user_groups_path
    else
      render :edit
    end
  end

  def destroy
    @user_group = UserGroup.find_by(user_id: params[:user_id], group_id: params[:group_id])
    @user_group.destroy
    redirect_to dashboard_admin_user_groups_path
  end

  private
  def user_group_params
    params.require(:user_group).permit(:user_id, :group_id)
  end
end
