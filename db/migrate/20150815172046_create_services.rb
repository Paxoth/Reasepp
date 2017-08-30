class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :publication, polymorphic: true, index: true
      t.references :creator
      t.references :acceptor
      t.references :area
      t.references :institution
      t.text :title
      t.integer :status
      t.text :message
      t.text :description
      t.text :resume
      t.date :start_time
      t.date :end_time
      t.text :objectives

      t.timestamps null: false
    end
  end
end
