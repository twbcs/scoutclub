class Article < ActiveRecord::Base
  belongs_to :user
  delegate :name, to: :user, prefix: "user"
  belongs_to :art_kind
  has_many :comments

  def set_user(user)
    self.user_id = user
  end
end
