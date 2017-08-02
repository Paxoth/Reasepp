class ChangeOrderToModule < ActiveRecord::Migration
  def change
  	rename_column :sections, :order, :module
  end
end
