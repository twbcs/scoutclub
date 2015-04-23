class Dashboard::PostsController < Dashboard::DashboardController
  before_action :post_list_power, only: [:show, :new, :edit]
  before_action :login,         except: [:show]
  before_action :set_post,        only: [:edit, :update, :destroy]
  before_action :set_forum,       only: [:show, :new, :edit]
  after_action :view_add,         only: [:show]

  def show
    @posts = Post.where('id = ? OR reply_id = ?', params[:id], params[:id])
             .includes(:user)
  end

  def new
    @post = Post.new(forum_id: params[:forum_id])
    @post.reply_id = params[:id] if params[:id]
    @posts = Post.where('id = ? OR reply_id = ?', params[:id], params[:id])
             .includes(:user) if params[:id]
  end

  def create
    @post = Post.new(post_params)
    @post.setup_user(current_user.id)
    @post.set_subject
    if @post.save
      reply_id?(@post)
    else
      set_forum
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      reply_id?(@post)
    else
      set_forum
      render :edit
    end
  end

  def destroy
    if @post.reply_id
      @post.destroy
      redirect_to dashboard_forum_post_path(forum_id: @post.forum_id, id: @post.reply_id)
    else
      @posts = Post.destroy_all(reply_id: params[:id])
      @post.destroy
      redirect_to dashboard_forum_path(@post.forum_id)
    end
  end

  private

  def post_params
    params.require(:post).permit(:forum_id, :subject, :body, :reply_id, :user_id, :update_post)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_forum
    @forum = Forum.find_by(id: params[:forum_id])
  end

  def post_list_power
    return unless current_user
    power = UserGroup.where(user_id: current_user.id).pluck(:group_id)
    view = GroupForum.where(group_id: power, forum_id: params[:forum_id])
           .pluck(:forum_id, :level)
    @post_view = view.sort.last
    redirect_to(dashboard_forums_path, alert: '子版錯誤或無權限進入') unless @post_view
  end

  def view_add
    view = Post.find(params[:id])
    view.update_column(:view_count, view.view_count + 1)
  end

  def login
    redirect_to(dashboard_forums_path, alert: '子版錯誤或無權限進入') unless current_user
  end

  def reply_id?(post)
    if post.reply_id
      redirect_to dashboard_forum_post_path(post.forum_id, post.reply_id)
    else
      redirect_to dashboard_forum_post_path(post.forum_id, post)
    end
  end
end
