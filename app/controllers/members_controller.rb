class MembersController < ApplicationController
  def index
    if params[:year]
      @year = params[:year]
      @members = Member.where(year: params[:year])
    else
      @members = Member.all.order_by_year
    end
    @years = Member.all.order_by_year.group(:year).select(:year)
  end
end
