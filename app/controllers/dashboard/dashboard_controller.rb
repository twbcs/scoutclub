class Dashboard::DashboardController < ApplicationController
  before_action :is_admin

  layout "dashboard"

  def is_admin
    if UserGroup.where(user_id: current_user.id, group_id: [2,7]).count > 0
      @admin = true
    end
    if UserGroup.where(user_id: current_user.id, group_id: 1).count > 0
      @superadmin = true
    end
  end
end
