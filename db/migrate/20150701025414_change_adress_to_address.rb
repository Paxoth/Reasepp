class ChangeAdressToAddress < ActiveRecord::Migration
  def change
    rename_column :events, :adress, :address
  end
end
