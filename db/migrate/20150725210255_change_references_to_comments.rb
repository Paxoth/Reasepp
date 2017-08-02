class ChangeReferencesToComments < ActiveRecord::Migration
  def change
  	change_table :comments do |t|
  	 t.remove :request_id
  	 t.remove :offering_id
  	end
  end
end
