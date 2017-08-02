class AddFieldsToInstitutions < ActiveRecord::Migration
  def change
    change_table :institutions do |t|
      t.string :name
      t.text :web
      t.timestamps null: false
    end
  end
end
