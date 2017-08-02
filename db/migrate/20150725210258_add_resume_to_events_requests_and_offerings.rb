class AddResumeToEventsRequestsAndOfferings < ActiveRecord::Migration
  def change
  	add_column :offerings, :resume, :text
  	add_column :requests, :resume, :text
  end
end
