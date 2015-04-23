class Board < ActiveRecord::Base
  include Right
  belongs_to :user
  delegate :name, :uid, :created_at, :last_sign_in_at, to: :user, prefix: 'user'

  validates_presence_of :user_id, on: :create, message: '不可為空'
  validates_presence_of :content, on: :create, message: '不可為空'
end
