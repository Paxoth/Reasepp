class ChangeStatusToInteger < ActiveRecord::Migration
  def change
	remove_column :events, :status
	add_column :events, :status, :integer, default: 1
	remove_column :offerings, :status
	add_column :offerings, :status, :integer, default: 1
	remove_column :requests, :status
	add_column :requests, :status, :integer, default: 1
  end
end
