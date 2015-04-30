class Dashboard::Admin::AdminController < ApplicationController
  before_action :user_rule
  layout 'admin'

  def user_rule
    # || forum_admin = Group.find_by(admin: true).
    redirect_to root_path unless Modify.find_by(user_id: current_user.id)
  end
end
