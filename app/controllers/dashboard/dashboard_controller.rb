class Dashboard::DashboardController < ApplicationController
  before_action :set_permission

  layout "dashboard"

  private
  def set_permission
    if UserGroup.where(user_id: current_user.id, group_id: [2,7]).count > 0
      @admin = true
    end
    if UserGroup.where(user_id: current_user.id, group_id: 1).count > 0
      @superadmin = true
    end
    if UserGroup.where(user_id: current_user.id, group_id: [2,4,5,7]).count > 0
      @inside = true
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
