class SchedulesController < ApplicationController
  def index
    if params[:doing_kind]
        @schedules = Schedule.where(doing_kind: params[:doing_kind]).includes(:doing_kind)
                      .order_by_time.paginate(:page => params[:page], :per_page => 20)
      else
        @schedules = Schedule.all.includes(:doing_kind).order_by_time
                      .paginate(:page => params[:page], :per_page => 20)
      end
      @kinds = DoingKind.all
  end

  def show
		@schedule = Schedule.find(params[:id])
  end
end
