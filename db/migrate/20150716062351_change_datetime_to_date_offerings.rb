class ChangeDatetimeToDateOfferings < ActiveRecord::Migration
  def change
  	change_column :offerings, :start_time, :date
    change_column :offerings, :end_time, :date
  end
end
