class MembersController < ApplicationController
  def index
  	@members = Member.all.order_by_year
  end
end
