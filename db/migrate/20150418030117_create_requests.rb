class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :user
      t.references :experience
      t.references :community
      t.references :area
      
      t.string :title
      t.text :description
      t.string :status
      t.datetime :start_time
      t.datetime :end_time



      t.timestamps
    end
  end
end
