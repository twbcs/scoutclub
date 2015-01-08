module Right
  extend ActiveSupport::Concern

  def set_user(user)
    self.user_id = user
  end
end
