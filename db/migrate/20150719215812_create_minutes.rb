class CreateMinutes < ActiveRecord::Migration
  def change
    create_table :minutes do |t|
      t.string :name
      t.date :date

      t.timestamps null: false
    end
  end
end
