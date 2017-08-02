class AddCategoryToUser < ActiveRecord::Migration
	def change
    	remove_column :users, :category_id
		add_column :users, :category, :integer
	end
end