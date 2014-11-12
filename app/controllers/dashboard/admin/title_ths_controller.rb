class Dashboard::Admin::TitleThsController < Dashboard::Admin::AdminController
  def index
    @title_ths = TitleTh.all.includes(:member, :title).order_by_year.order_by_title
    @year = TitleTh.all.order_by_year.group(:title_year).select(:title_year)
  end
end
