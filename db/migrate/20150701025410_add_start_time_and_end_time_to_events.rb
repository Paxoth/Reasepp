class AddStartTimeAndEndTimeToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
