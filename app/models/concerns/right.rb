module Right
  extend ActiveSupport::Concern

  def setup_user(user)
    self.user_id = user
  end
end
