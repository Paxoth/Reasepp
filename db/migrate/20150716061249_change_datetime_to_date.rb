class ChangeDatetimeToDate < ActiveRecord::Migration
  def change
  	change_column :requests, :start_time, :date
    change_column :requests, :end_time, :date
  end
end


