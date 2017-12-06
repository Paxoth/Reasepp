class AddBrokerToServicesActivities < ActiveRecord::Migration
  def change
  	add_column :offerings, :broker_id, :integer
  	add_column :requests, :broker_id, :integer
  	add_column :services, :broker_id, :integer
  	add_column :experiences, :broker_id, :integer
  end
end
