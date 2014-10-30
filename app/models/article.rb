class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :art_type
  has_many :comments

  def set_user(user)
    self.user_id = user
  end
end
