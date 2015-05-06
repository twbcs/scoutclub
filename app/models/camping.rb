class Camping < ActiveRecord::Base
  validates_presence_of :name, on: :create, message: '不能為空'
  validates_presence_of :area, on: :create, message: '不能為空'
  AREA = [['請選擇', nil], ['北部', 1], ['中部', 2], ['南部', 3], ['東部', 4], ['離島', 5]]
end
