class SchedulesController < ApplicationController
	before_action :set_schedule, only: [:edit, :update, :destroy, :show]
  def index
  	@schedules = Schedule.all.includes(:doing_type).order_by_time
  end

  def new
  	@schedule = Schedule.new
  end

  def create
  	@schedule = Schedule.new(scheduls_params)
  	if @schedule.save
  		redirect_to schedules_url
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @schedule.update(scheduls_params)
  		redirect_to schedules_url
  	else
  		render :edit
  	end
  end

  def destroy
  	@schedule.destroy
  end

  def show

  end

  private
  def set_schedule
  	@schedule = Schedule.find(params[:id])
  end

	def scheduls_params
  	params.require(:schedule).permit(:title, :start_date, :end_date, :public_at,
		 :local, :number, :description, :doing_type_id)
  end
end
