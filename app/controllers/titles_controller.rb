class TitlesController < ApplicationController
  def index
    if params[:id]
      @title = Title.find(params[:id])
    else
      @title = Title.where(level: 1).first
    end
    @titles = Title.all.order_by_level.select(:id, :title, :level)
  end

  def title_ths
    @title_ths = TitleTh.all.includes(:member, :title)
                 .order_by_year.order_by_title
    @year = TitleTh.all.order_by_year.group(:title_year).select(:title_year)
  end
end
