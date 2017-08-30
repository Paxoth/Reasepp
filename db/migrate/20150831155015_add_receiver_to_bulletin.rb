class AddReceiverToBulletin < ActiveRecord::Migration
  def change
    add_column :bulletins, :receiver, :integer
  end
end
