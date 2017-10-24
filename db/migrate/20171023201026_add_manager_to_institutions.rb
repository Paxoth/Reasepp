class AddManagerToInstitutions < ActiveRecord::Migration
  def change
  	add_column :institutions, :manager_id, :integer
  end
end
