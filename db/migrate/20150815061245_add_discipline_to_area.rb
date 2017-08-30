class AddDisciplineToArea < ActiveRecord::Migration
  def change
    add_column :areas, :discipline, :text
  end
end
