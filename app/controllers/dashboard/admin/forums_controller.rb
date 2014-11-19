class Dashboard::Admin::ForumsController < Dashboard::Admin::AdminController
  before_action :forum_list_power, only: [:index]
  before_action :post_list_power, only: [:show]
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

  def index
    @forum_kinds = ForumKind.all
    @forums = Forum.all.order_by_forum_kind.includes(:posts)
    @posts = Post.includes(:user).find_first_post
    @reply = Post.find_reply_count.inject({}) do |result, reply|
      result.merge(reply[:forum_id] => reply[:reply_id])
    end
    @post_count = Post.where( reply_id: nil).group(:forum_id).count
    @reply_count = Post.all.group(:forum_id).count
  end

  def new
    @forum = Forum.new
    @forum.forum_kind_id = params[:forum_kind_id]
  end

  def create
    @forum = Forum.new(forum_params)
    if @forum.save
      redirect_to(dashboard_admin_forum_kinds_url, notice: '新增討論板完成')
    else
      render :new
    end
  end

  def show
    @posts = Post.where(forum_id: params[:id], reply_id: nil).includes(:user)
            .paginate(:page => params[:page], :per_page => 20).order_by_update_post
  end

  def edit
  end

  def update
    if @forum.update(forum_params)
      redirect_to(dashboard_admin_forum_kinds_url, notice: '修改討論板完成')
    else
      render :edit
    end
  end

  def destroy
    post = Post.where(forum_id: params[:id]).count
    if post < 1
      @group_forums = GroupForum.where(forum_id: params[:id])
      @group_forums.each{|x| x.destroy} if @group_forums
      @forum.destroy
      redirect_to(dashboard_admin_forum_kinds_url, notice: '討論板已刪除')
    else
      redirect_to(dashboard_admin_forum_kinds_url, alert: '板內有文章，無法進行刪除作業')
    end
  end

  private

  def forum_params
    params.require(:forum).permit(:forum_kind_id, :title, :description, :public_at, :closing_date )
  end

  def set_forum
    @forum = Forum.find(params[:id])
  end

  def post_list_power
    if current_user
      view = Array.new
      temp1 = Array.new
      power = UserGroup.where(user_id: current_user.id)
      power.each{|x| temp1 << x.group_id}
      temp2 = GroupForum.where(group_id: temp1, forum_id: params[:id])
      temp2.each{|v| view << [v.forum_id, v.level]}
      @post_view = view.sort.last
      redirect_to(dashboard_admin_forums_path, alert: '子版錯誤或無權限進入') unless @post_view
    end
  end

  def forum_list_power
    if current_user
      @forum_view = Array.new
      temp1 = Array.new
      power = UserGroup.where(user_id: current_user.id)
      power.each{|x| temp1 << x.group_id}
      temp2 = GroupForum.where(group_id: temp1)
      temp2.each{|v| @forum_view << v.forum_id}
      @forum_view.sort!.uniq!
    end
  end
end
