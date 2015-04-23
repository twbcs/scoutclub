class PostsController < ApplicationController
  before_action :post_list_power, only: [:show, :new, :edit]
  before_action :login,         except: [:show]
  after_action :view_add,        only: [:show]

  def show
    @posts = Post.where('id = ? OR reply_id = ?', params[:id], params[:id])
             .includes(:user)
    @forum = Forum.find_by(id: params[:forum_id])
  end

  private

  def post_list_power
    return unless current_user
    power = UserGroup.where(user_id: current_user.id).pluck(:group_id)
    view = GroupForum.where(group_id: power, forum_id: params[:forum_id])
           .pluck(:forum_id, :level)
    @post_view = view.sort.last
    redirect_to(forums_path, alert: '子版錯誤或無權限進入') unless @post_view
  end

  def view_add
    view = Post.find(params[:id])
    view.update_column(:view_count, view.view_count + 1)
  end

  def login
    redirect_to(forums_path, alert: '子版錯誤或無權限進入') unless current_user
  end
end
