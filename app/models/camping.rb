class Camping < ActiveRecord::Base
  validates_presence_of :name, on: :create, message: '不能為空'
end
