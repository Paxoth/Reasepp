class ChangeServiceTable < ActiveRecord::Migration
change_table :services do |t|
	t.rename :objectives, :learning_objectives
	t.text :service_objectives
end
end

