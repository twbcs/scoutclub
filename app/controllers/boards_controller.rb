class BoardsController < ApplicationController
  # GET /boards
  def index
    @boards = Board.all.includes(:user).page_set(params[:page]).order_by
  end
end
