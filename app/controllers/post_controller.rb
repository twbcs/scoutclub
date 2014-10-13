class PostController < ApplicationController

  def show
    @post = Psot.find(params[:id])
  end

  def new
    @post = Post.new
    @post.reply_id =|| params[:reply_id]
    @post.forum_id = params[:forum_id]
    if params[:reply_id]
      @posts = Post.where("id = ? OR reply_id = ?", params[:reply_id], params[:reply_id])
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if @post.reply_id
        po = Post.find_by(id: @post.reply_id)
        po.update(params.require(:post).permit(:updated_at Time.now))
      end
      redirect_to forum_post_path(@post.forum_id, @post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
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
