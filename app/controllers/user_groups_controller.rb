class UserGroupsController < ApplicationController
  before_action :user_rule
  def index
    @user_rule = Modify.find_by(user_id: current_user)
    @user_groups = User.all.includes(:groups)
  end

  def new
    @user_group = UserGroup.new
    @user_group.user_id = params[:user_id]
  end

  def create
    @user_group = UserGroup.new(ug_params)
    if @user_group.save
      redirect_to user_groups_path
    else
      render :new
    end
  end

  def edit
    @user_group = UserGroup.find_by(user_id: params[:user_id], group_id: params[:group_id])
  end

  def update
    @user_group = UserGroup.find(params[:id])
    if @user_group.update(ug_params)
      redirect_to user_groups_path
    else
      render :edit
    end
  end

  def destroy
    @user_group = UserGroup.find_by(user_id: params[:user_id], group_id: params[:group_id])
    @user_group.destroy
    redirect_to user_groups_path
  end

  private
  def ug_params
    params.require(:user_group).permit(:user_id, :group_id)
  end

  def user_rule
    unless admin = Modify.find_by(user_id: current_user)# || forum_admin = Group.find_by(admin: true).
      redirect_to root_path
    end
  end
end
