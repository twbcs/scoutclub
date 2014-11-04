class TitlesController < ApplicationController
  def index
  	@titles = Title.all.order_by_level
  end
end
