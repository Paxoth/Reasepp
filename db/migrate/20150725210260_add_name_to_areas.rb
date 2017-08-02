class AddNameToAreas < ActiveRecord::Migration
  def change
  	add_column :areas, :name, :string
  end
end
