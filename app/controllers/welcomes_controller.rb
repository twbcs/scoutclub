class WelcomesController < ApplicationController
  before_action :login_in

  def index
    @post_list     = Post.where(reply_id: nil).order_by_update_post.limit(5).
                      includes(:forum).where('forums.public_at = ?', true).references(:forums)
    @schedule_list = Schedule.where.not(doing_kind_id: 2, public_at: "").
                            where('public_at < ?', Time.now).order_by_time.limit(5)
    @training_list = Schedule.where(doing_kind_id: 2).where.not(public_at: "").
                            where('public_at < ?', Time.now).order_by_time.limit(5)
    @articles_list = Article.all.order_by_time.limit(5)
    @album_list    = Album.where.not(public_at: "").where('public_at < ?', Time.now).order_by_time.limit(5)
    @movie_list    = Movie.where(public_is: true).order_by_time.limit(5)
  end

  def error_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  private
  def login_in
    if current_user
      redirect_to dashboard_root_path
    end
  end
end
