class AddRelationToFloatEntities < ActiveRecord::Migration
  def change
  	add_reference :questions, :user, default: 1	
  	add_reference :interest_links, :user, default: 1
  	add_reference :resources, :user, default: 1
  	add_reference :bulletins, :user, default: 1
  	add_reference :sections, :user, default: 1
  end
end
