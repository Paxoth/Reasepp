class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
     t.string :tittle
     t.text :description
     t.timestamps
     t.references :user
     t.references :request
     t.references :service_offering
    end
  end
end