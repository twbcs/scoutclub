class Dashboard::TitlesController < Dashboard::DashboardController
	before_action :set_title, only: [:edit, :update, :destroy]

  def index
		if params[:id]
			@title = Title.find(params[:id])
		else
			@title = Title.where(level: 1).first
		end
		@titles = Title.all.order_by_level.select(:id, :title, :level)
  end

  def edit
  end

  def update
  	if @title.update(title_params)
  		redirect_to dashboard_titles_url, notice: '資料已更新'
  	else
  		render :edit
  	end
  end

  private

  def set_title
  	@title = Title.find(params[:id])
  end

  def title_params
  	params.require(:title).permit(:title, :description, :level)
  end
end
