class AddAreaReferencesToExperiences < ActiveRecord::Migration
  def change
  	add_reference :experiences, :area
  end
end
