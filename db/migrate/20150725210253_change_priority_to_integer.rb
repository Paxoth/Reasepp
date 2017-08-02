class ChangePriorityToInteger < ActiveRecord::Migration
	def change
		remove_column :sections, :priority
		add_column :sections, :priority, :integer, default: 1
	end
end
