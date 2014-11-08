class Dashboard::TitleThsController < Dashboard::DashboardController
  def index
    @title_ths = TitleTh.all.includes(:member, :title).order_by_year.order_by_title
  end
end
