class Dashboard::Admin::SchedulesController < Dashboard::Admin::AdminController
	before_action :set_schedule, only: [:edit, :update, :destroy, :show]
  def index
  	if params[:doing_kind_id]
				@schedules = Schedule.where(doing_kind_id: params[:doing_kind_id]).includes(:doing_kind)
											.order_by_time.paginate(:page => params[:page], :per_page => 20)
			else
				@schedules = Schedule.all.includes(:doing_kind).order_by_time
											.paginate(:page => params[:page], :per_page => 20)
			end
			@kinds = DoingKind.all
  end

  def new
  	@schedule = Schedule.new
  end

  def create
  	@schedule = Schedule.new(scheduls_params)
  	if @schedule.save
  		redirect_to dashboard_admin_schedules_url
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @schedule.update(scheduls_params)
  		redirect_to dashboard_admin_schedules_url
  	else
  		render :edit
  	end
  end

  def destroy
  	@schedule.destroy
		redirect_to dashboard_admin_schedules_url
  end

  def show
  end

  private
  def set_schedule
  	@schedule = Schedule.find(params[:id])
  end

	def scheduls_params
  	params.require(:schedule).permit(:title, :start_date, :end_date, :public_at,
		 :local, :number, :description, :doing_kind_id)
  end
end
