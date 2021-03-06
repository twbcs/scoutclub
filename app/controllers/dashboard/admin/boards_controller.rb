class Dashboard::Admin::BoardsController < Dashboard::Admin::AdminController
  before_action :set_board, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all.includes(:user).page_set(params[:page]).order_by
  end

  def new
    @board = Board.new
  end

  def edit
  end

  def create
    @board = Board.new(board_params)
    @board.set_user(current_user.id)
    if @board.save
      redirect_to dashboard_admin_boards_url, notice: '留言已新增.'
    else
      render(:new)
    end
  end

  def update
    params[:board][:content] << "\n\n由#{current_user.name}修改於#{Time.now.strftime('%Y年%m月%d日 %H:%S')}"
    if @board.update(board_params)
      redirect_to dashboard_admin_boards_url, notice: '修改完成.'
    else
      render(:edit)
    end
  end

  def destroy
    @board.destroy
    redirect_to dashboard_admin_boards_url, notice: '留言已刪除.'
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:user_id, :subject, :content)
  end
end
