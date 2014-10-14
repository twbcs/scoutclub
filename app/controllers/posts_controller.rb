class PostsController < ApplicationController

  def show
    @posts = Post.where("id = ? OR reply_id = ?", params[:id], params[:id])
            .includes(:user)
    @forum = Forum.find_by(id: params[:forum_id])

  end

  def new
    @post = Post.new
    @post.reply_id = params[:reply_id] if params[:reply_id]
    @post.forum_id = params[:forum_id]
    @post.user_id = current_user.id
    @forum = Forum.find_by(id: params[:forum_id])
    @posts = Post.where("id = ? OR reply_id = ?", params[:reply_id], params[:reply_id])
            .includes(:user) if params[:reply_id]
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if @post.reply_id
        redirect_to forum_post_path(@post.forum_id, @post.reply_id)
      else
        redirect_to forum_post_path(@post.forum_id, @post)
      end

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
