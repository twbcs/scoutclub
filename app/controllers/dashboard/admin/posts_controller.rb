class Dashboard::Admin::PostsController < Dashboard::Admin::AdminController
  before_action :post_list_power, only: [:show, :new, :edit]
  before_action :login,         except: [:show]
  before_action :set_post,        only: [:edit, :update, :destroy]
  after_action  :view_add,        only: [:show]

  def show
    @posts = Post.where("id = ? OR reply_id = ?", params[:id], params[:id])
            .includes(:user)
    @forum = Forum.find_by(id: params[:forum_id])
  end

  def new
    @post = Post.new(forum_id: params[:forum_id])
    @post.reply_id = params[:id] if params[:id]
    @forum = Forum.find_by(id: params[:forum_id])
    @posts = Post.where("id = ? OR reply_id = ?", params[:id], params[:id])
            .includes(:user) if params[:id]
  end

  def create
    @post = Post.new(post_params)
    @post.set_user(current_user.id)
    if @post.save
      if @post.reply_id
        redirect_to dashboard_admin_forum_post_path(@post.forum_id, @post.reply_id)
      else
        redirect_to dashboard_admin_forum_post_path(@post.forum_id, @post)
      end
    else
      render :new
    end
  end

  def edit
      @forum = Forum.find_by(id: params[:forum_id])
  end

  def update
    if @post.update(post_params)
      if @post.reply_id
        redirect_to dashboard_admin_forum_post_path(@post.forum_id, @post.reply_id)
      else
        redirect_to dashboard_admin_forum_post_path(@post.forum_id, @post)
      end
    else
      render :edit
    end
  end

  def destroy
    if @post.reply_id
      @post.destroy
      redirect_to dashboard_admin_forum_post_path(forum_id: @post.forum_id, id: @post.reply_id)
    else
      @posts = Post.where(reply_id: params[:id])
      @posts.each{|x| x.destroy} if @posts
      @post.destroy
      redirect_to dashboard_admin_forum_path(@post.forum_id)
    end
  end

  private
  def post_params
    params.require(:post).permit(:forum_id, :subject, :body, :reply_id, :user_id, :update_post)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_list_power
    if current_user
      view = Array.new
      temp1 = Array.new
      power = UserGroup.where(user_id: current_user.id)
      power.each{|x| temp1 << x.group_id}
      temp2 = GroupForum.where(group_id: temp1, forum_id: params[:forum_id])
      temp2.each{|v| view << [v.forum_id, v.level]}
      @post_view = view.sort.last
      redirect_to(dashboard_admin_forums_path, alert: '子版錯誤或無權限進入') unless @post_view
    end
  end

  def view_add
    view = Post.find(params[:id])
    view.update_column(:view_count, view.view_count + 1)
  end

  def login
    redirect_to(dashboard_admin_forums_path, alert: '子版錯誤或無權限進入') unless current_user
  end
end
