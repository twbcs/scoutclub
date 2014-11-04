class SchedulesController < ApplicationController
  def index
  	@schedules = Schedule.all.includes(:doing_type).order_by_time
  end

  def show
		@schedule = Schedule.find(params[:id])
  end
end
