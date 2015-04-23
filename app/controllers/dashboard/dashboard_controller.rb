class Dashboard::DashboardController < ApplicationController
  before_action :set_permission

  layout 'dashboard'

  private

  def set_permission
    session[:user_level] = UserGroup.where(user_id: current_user.id)
                           .pluck(:group_id) unless session[:user_level]
    user_level = session[:user_level]
    @admin = true if [1, 2, 7].any? { |i| user_level.include?(i) }
    @superadmin = true if user_level.include?(1)
    @inside = true if [2, 4, 5, 7].any? { |i| user_level.include?(i) }
    @junior = true if user_level.include?(3)
  end

  def is_inside
    redirect_to root_path unless @inside
  end

  def is_admin
    redirect_to root_path unless @admin
  end
end
