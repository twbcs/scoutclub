class Dashboard::Admin::BoardsController < Dashboard::Admin::AdminController
  before_action :set_board, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /boards
  def index
    @boards = Board.all.includes(:user).paginate(:page => params[:page], :per_page => 20)
                      .order('created_at DESC')
  end

  # GET /boards/new
  def new
    @board = Board.new
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards
  def create
    @board = Board.new(board_params)
    @board.set_user(current_user.id)
    if @board.save
      redirect_to dashboard_admin_boards_url, notice: '留言已新增.'
    else
      render(:new )
    end
  end

  # PATCH/PUT /boards/1
  def update
    params[:board][:content] << "\n\n由#{current_user.name}修改於#{Time.now.strftime('%Y年%m月%d日 %H:%S')}"
    if @board.update(params.require(:board).permit(:user_id, :subject, :content ))
      redirect_to dashboard_admin_boards_url, notice: '修改完成.'
    else
      render(:edit)
    end
  end

  # DELETE /boards/1
  def destroy
    @board.destroy
    redirect_to dashboard_admin_boards_url, notice: '留言已刪除.'
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
end
