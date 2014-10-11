class ForumsController < ApplicationController

  def index
    @forum_types = ForumType.all
    @forums = Forum.all.order_by_forum_type
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
    @post = Post.find_by(forum_id: params[:id])
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
    @forum = Forum.find(params[:id])
    if @forum.post.count < 1
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
end
