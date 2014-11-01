class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article

  def set_user(user)
    self.user_id = user
  end
end
