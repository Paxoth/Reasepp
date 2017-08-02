class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.references :user, index: true, foreign_key: true
      #t.references :experience, index: true, foreign_key: true
      #t.references :community, index: true, foreign_key: true
      #t.references :area, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.string :status
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
