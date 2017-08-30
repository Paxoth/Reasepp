class RenameMinutes < ActiveRecord::Migration
	def self.up
		rename_table :minutes, :resources
	end

	def self.down
		rename_table :resources, :minutes
	end
end
