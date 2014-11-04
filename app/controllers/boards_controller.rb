class BoardsController < ApplicationController
  # GET /boards
  def index
    @boards = Board.all.includes(:user).paginate(:page => params[:page], :per_page => 20)
                      .order('created_at DESC')
  end
end
