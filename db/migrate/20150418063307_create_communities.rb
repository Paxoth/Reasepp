class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
    	t.references :request
    	t.references :services_offering
    end
  end
end
