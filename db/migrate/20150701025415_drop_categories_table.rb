class DropCategoriesTable < ActiveRecord::Migration
	def down
		drop_table :categories
	end
end
