class AddAreaReferencesToOffering < ActiveRecord::Migration
  def change
    add_reference :offerings, :area
  end
end
