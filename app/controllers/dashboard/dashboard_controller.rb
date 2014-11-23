class Dashboard::DashboardController < ApplicationController
  before_action :set_permission

  layout "dashboard"

  private
  def set_permission
    session[:user_level] = UserGroup.where(user_id: current_user.id).pluck(:group_id) unless session[:user_level]
    user_level = session[:user_level]
    if [1, 2, 7].any? { |i| user_level.include?(i) }
      @admin = true
    end
    if user_level.include?(1)
      @superadmin = true
    end
    if [2,4,5,7].any? { |i| user_level.include?(i) }
      @inside = true
    end
    if user_level.include?(3)
      @junior = true
    end
  end

  def is_inside
    unless @inside
      redirect_to root_path
    end
  end

  def is_admin
    unless @admin
      redirect_to root_path
    end
  end
end
