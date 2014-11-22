class Dashboard::TitlesController < Dashboard::DashboardController
	before_action :set_title, only: [:edit, :update, :destroy]
	before_action :is_inside, except: [:index, :title_ths]

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

	def title_ths
		@title_ths = TitleTh.all.includes(:member, :title).order_by_year.order_by_title
		@year = TitleTh.all.order_by_year.group(:title_year).select(:title_year)
	end

  private

  def set_title
  	@title = Title.find(params[:id])
  end

  def title_params
  	params.require(:title).permit(:title, :description, :level)
  end
end
