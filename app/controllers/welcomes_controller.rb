class WelcomesController < ApplicationController
  def index
    @post_list     = Post.where(first_post: true).order_by_update_post.limit(5).includes(:forum)
    @schedule_list = Schedule.where.not(doing_type_id: 2).order_by_time.limit(5)
    @training_list = Schedule.where(doing_type_id: 2).order_by_time.limit(5)
  end

  def error_404
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

end
