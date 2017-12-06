class RemoveWrongsAttributes < ActiveRecord::Migration
  def change
	remove_reference(:requests, :community, index: true)
	remove_reference(:requests, :experience, index: true)
  end
end
