class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
    	t.text :description
    end
  end
end
