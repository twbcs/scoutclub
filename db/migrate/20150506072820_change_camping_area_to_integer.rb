class ChangeCampingAreaToInteger < ActiveRecord::Migration
  def change
    change_column :campings, :area, :integer, limit: 1, unsigned: true
  end
end
