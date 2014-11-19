class ForumsController < ApplicationController
  before_action :forum_list_power, only: [:index]
  before_action :post_list_power, only: [:show]

  def index
    @forum_kinds = ForumKind.all
    @forums = Forum.all.order_by_forum_kind.includes(:posts).where(public_at: true)
    @posts = Post.includes(:user).find_first_post
    @reply = Post.find_reply_count.inject({}) do |result, reply|
      result.merge(reply[:forum_id] => reply[:reply_id])
    end
    @post_count = Post.where( reply_id: nil).group(:forum_id).count
    @reply_count = Post.all.group(:forum_id).count
  end

  def show
    @forum = Forum.find(params[:id])
    @posts = Post.where(forum_id: params[:id], reply_id: nil).includes(:user)
            .paginate(:page => params[:page], :per_page => 20).order_by_update_post
  end

  private

  def post_list_power
    if current_user
      view = Array.new
      temp1 = Array.new
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
