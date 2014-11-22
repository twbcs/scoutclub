class Dashboard::WelcomesController < Dashboard::DashboardController
  def index
    @post_list     = Post.where(reply_id: nil).order_by_update_post.limit(5).includes(:forum)
    @schedule_list = Schedule.where.not(doing_kind_id: 2).order_by_time.limit(5)
    @training_list = Schedule.where(doing_kind_id: 2).order_by_time.limit(5)
    @articles_list = Article.all.order_by_time.limit(5)
    @album_list    = Album.all.order_by_time.limit(5)
    @movie_list    = Movie.all.order_by_time.limit(5)
  end

  def error_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end
