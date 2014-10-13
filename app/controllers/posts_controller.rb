class PostsController < ApplicationController

  def show
    @post = Post.where(id: params[:id]).includes(:user).first
    @forum = Forum.find_by(id: params[:forum_id])

  end

  def new
    @post = Post.new
    @post.reply_id = params[:reply_id] if params[:reply_id]
    @post.forum_id = params[:forum_id]
    @post.user_id = current_user.id
    @forum = Forum.find_by(id: params[:forum_id])
    if params[:reply_id]
      @posts = Post.where("id = ? OR reply_id = ?", params[:reply_id], params[:reply_id])
        .includes(:user)
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to forum_post_path(@post.forum_id, @post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @forum = Forum.find_by(id: params[:forum_id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to forum_post_path(@post.forum_id, @post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to forum_path(@post.forum_id)
  end

  private
  def post_params
    params.require(:post).permit(:forum_id, :subject, :body, :reply_id, :user_id)
  end
end
