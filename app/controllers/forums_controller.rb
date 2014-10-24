class ForumsController < ApplicationController
  before_action :forum_list_power, only: [:index]
  before_action :post_list_power, only: [:show]

  def index
    @forum_types = ForumType.all
    @forums = Forum.all.order_by_forum_type.includes(:posts)
    @posts = Post.includes(:user).find_by_sql("select * from (select * from posts
              where reply_id IS NULL order by updated_at DESC) t group by forum_id")
    @post_count = Post.where( reply_id: nil).group(:forum_id).count
    @reply_count = Post.all.group(:forum_id).count
  end

  def new
    @forum = Forum.new
    @forum.forum_type_id = params[:forum_type_id]
  end

  def create
    @forum = Forum.new(forum_params)
    if @forum.save
      redirect_to(forum_types_url, notice: '新增討論板完成')
    else
      render :new
    end
  end

  def show
    @forum = Forum.find(params[:id])
    @posts = Post.where(forum_id: params[:id], reply_id: nil).includes(:user)
            .order_by_updated_at
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])
    if @forum.update(forum_params)
      redirect_to(forum_types_url, notice: '修改討論板完成')
    else
      render :edit
    end
  end

  def destroy
    @forum = Forum.find(params[:id]).includes(:posts)
    if @forum.post.count < 1
      @group_forums = GroupForum.where(forum_id: params[:id])
      @group_forums.each{|x| x.destroy} if @group_forums
      @forum.destroy
      redirect_to(forum_types_url, notice: '討論板已刪除')
    else
      redirect_to(forum_types_url, alert: '板內有文章，無法進行刪除作業')
    end
  end

  private

  def forum_params
    params.require(:forum).permit(:forum_type_id, :title, :description, :public_at, :closing_date )
  end

  def post_list_power
    if current_user
      temp1 = Array.new
      view  = Array.new
      power = UserGroup.where(user_id: current_user.id)
      power.each{|x| temp1 << x.group_id}
      temp2 = GroupForum.where(group_id: temp1, forum_id: params[:id])
      temp2.each{|v| view << [v.forum_id, v.level]}
      @post_view = view.sort.last
      redirect_to(forums_path, alert: '子版錯誤或無權限進入') unless @post_view
    end
  end

  def forum_list_power
    if current_user
      temp1 = Array.new
      @forum_view = Array.new
      power = UserGroup.where(user_id: current_user.id)
      power.each{|x| temp1 << x.group_id}
      temp2 = GroupForum.where(group_id: temp1)
      temp2.each{|v| @forum_view << v.forum_id}
      @forum_view.sort!.uniq!
    end
  end
end
