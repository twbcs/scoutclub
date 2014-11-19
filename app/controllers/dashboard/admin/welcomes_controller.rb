class Dashboard::Admin::WelcomesController < Dashboard::Admin::AdminController
  def index
    @post_list     = Post.where(reply_id: nil).order_by_update_post.limit(5).includes(:forum)
    @schedule_list = Schedule.where.not(doing_kind_id: 2).order_by_time.limit(5)
    @training_list = Schedule.where(doing_kind_id: 2).order_by_time.limit(5)
    @articles_list = Article.all.order_by_time.limit(5)
    @album_list    = Album.all.order_by_time.limit(5)
  end
end
