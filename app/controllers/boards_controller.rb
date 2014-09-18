class BoardsController < ApplicationController
  before_action :set_board, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  #before_action :set_user_level

  # GET /boards
  def index
    @boards = Board.all.includes(:user).paginate(:page => params[:page], :per_page => 20).order('created_at DESC')
  end


  # GET /boards/new
  def new
    @board = Board.new
    render(:new, :layout=>false)
  end

  # GET /boards/1/edit
  def edit
    render(:edit, :layout=>false)
  end

  # POST /boards
  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id

    if @board.save
      redirect_to boards_url, notice: '留言已新增.'
    else
      render(:new, :layout=>false)
    end
  end

  # PATCH/PUT /boards/1
  def update
    params[:board][:content] << "\n\n由#{current_user.name}修改於#{Time.now.strftime('%Y年%m月%d日 %H:%S')}"
    if @board.update(params.require(:board).permit(:user_id, :subject, :content ))
      redirect_to boards_url, notice: '修改完成.'
    else
      render(:edit, :layout=>false)
    end
  end

  # DELETE /boards/1
  def destroy
    @board.destroy
    redirect_to boards_url, notice: '留言已刪除.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def board_params
      params.require(:board).permit(:user_id, :subject, :content)
    end

    def set_user_level
      if current_user
        @user_level = current_user.user_level
      else
        @user_level = 0
      end
    end
end
