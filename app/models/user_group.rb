class UserGroup < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  scope :find_set, -> { find_by(user_id: params[:user_id], group_id: params[:group_id]) }
end
