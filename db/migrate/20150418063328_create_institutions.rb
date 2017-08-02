class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
     t.text :description
    end
  end
end