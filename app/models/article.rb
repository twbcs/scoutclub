class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :art_type
  has_many :comments
end
