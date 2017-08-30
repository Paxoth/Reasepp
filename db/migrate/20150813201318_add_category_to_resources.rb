class AddCategoryToResources < ActiveRecord::Migration
  def change
    add_column :resources, :category, :integer, default: 1
    add_column :resources, :description, :text
  end
end
