class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.text :text
    	t.timestamps
    	t.references :user
    	t.references :request
    	t.references :service_offering
    	
    end
  end
end
