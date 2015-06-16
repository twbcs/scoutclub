class SchedulesController < ApplicationController
  before_action :kind_count, only: [:index]

  def index
    if params[:doing_kind_id]
      @schedules = Schedule.where(doing_kind_id: params[:doing_kind_id])
                   .on_public.includes(:doing_kind)
                   .order_by_time.page_set(params[:page])
    else
      @schedules = Schedule.on_public.includes(:doing_kind)
                   .order_by_time.page_set(params[:page])
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  private

  def kind_count
    @kind_count = Schedule.where.not(public_at: '').group(:doing_kind_id).count
    @kinds = DoingKind.all
  end
end
