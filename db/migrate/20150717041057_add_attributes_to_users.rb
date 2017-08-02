class AddAttributesToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :nickname, :string
  	add_attachment  :users,:photo
  	add_column :users, :description, :text

  end
end
