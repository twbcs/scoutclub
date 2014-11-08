class Comment < ActiveRecord::Base
  include Right
  belongs_to :user
  delegate :name, to: :user, prefix: "user"
  belongs_to :article

end
