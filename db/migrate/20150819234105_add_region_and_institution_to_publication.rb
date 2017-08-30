class AddRegionAndInstitutionToPublication < ActiveRecord::Migration
	def up
		add_column :requests, :location, :text
		add_column :offerings, :location, :text
		add_reference :requests, :institution
		add_reference :offerings, :institution
	end
	def down
		remove_column :requests, :location
		remove_column :offerings, :location
		remove_reference :requests, :institution
		remove_reference :offerings, :institution
	end
end
