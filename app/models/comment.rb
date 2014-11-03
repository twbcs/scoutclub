class Comment < ActiveRecord::Base
  include Right
  belongs_to :user
  belongs_to :article

end
