class TitlesController < ApplicationController
  def index
    if params[:id]
      @title = Title.find(params[:id])
    else
      @title = Title.where(level: 1).first
    end
    @titles = Title.all.order_by_level.select(:id, :title, :level)
  end
end
