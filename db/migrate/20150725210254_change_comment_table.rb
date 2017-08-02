class ChangeCommentTable < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove :service_offering_id
      t.remove :text
      t.references :offering
      t.references :event
      t.text :body
    end
  end
end
